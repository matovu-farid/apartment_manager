# frozen_string_literal: true

class ResidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resident, only: %i[show edit update destroy]
  include Payable

  load_and_authorize_resource
  # GET /residents or /residents.json
  def index
    # @residents = Resident.kept.accessible_by(current_ability)
    @q = Resident.kept.accessible_by(current_ability).ransack(params[:q])
    @residents = @q.result(distinct: true).includes(:apartment)

  end

  # GET /residents/1 or /residents/1.json
  def show; end

  # GET /residents/new
  def new
    @resident = Resident.new
    return unless Apartment.accessible_by(current_ability).is_occupied.empty?

    redirect_to(new_apartment_path)
  end

  # GET /residents/1/edit
  def edit; end

  # POST /residents or /residents.json
def create
  @resident = Resident.new(resident_params)

  # Use a transaction to ensure both records are saved together
  ActiveRecord::Base.transaction do
    @resident.save!
    RentSession.create!(
      paymentDueDate: @resident.startdate, 
      resident: @resident, 
      apartment: @resident.apartment,
      amount: @resident.apartment.price
    )
  end

  respond_to do |format|
    format.html { redirect_to resident_url(@resident), notice: 'Resident was successfully created.' }
    format.json { render :show, status: :created, location: @resident }
  end

rescue ActiveRecord::RecordInvalid => e
  respond_to do |format|
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: e.record.errors, status: :unprocessable_entity }
  end
end

def create_rent_sessions
  Resident.all.each {|resident| resident.find_or_create_current_rent_session}
  redirect_to(residents_path, notice: 'Rent sessions were successfully created.')
end

  def setup_payment
    @resident = Resident.find(params[:resident_id])
    redirect_to(resident_payments_path(@resident))
  end

  def add_payment
    @resident = Resident.find(params[:resident_id])
    @payment = Payment.new({ date: params[:date], amount: params[:amount] })
    @rent_session = create_rent_session(@resident)
    @payment.rent_session = @rent_session

    respond_to do |format|
      if @payment.save
        format.html do
          redirect_to(residents_path, notice: 'Payment was successfully created.')
        end
        format.json { render(:show, status: :created, location: @payment) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @payment.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /residents/1 or /residents/1.json
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to(resident_url(@resident), notice: 'Resident was successfully updated.') }
        format.json { render(:show, status: :ok, location: @resident) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @resident.errors, status: :unprocessable_entity) }
      end
    end
  end

  def archives
    # Recover archived residents from ResidentArchive and update their apartment to the aparment from the ResidentArchive
    @archived_residents = []

    ResidentArchive.all.each do |resident_archive|
      resident = resident_archive.resident
      resident.is_not_archived = false
      resident.apartment = resident_archive.apartment
      @archived_residents << resident
    end
   
  end

  # DELETE /residents/1 or /residents/1.json
  def destroy
    ActiveRecord::Base.transaction do
      @resident.discard!

      ResidentArchive.create!(
        resident: @resident, 
        apartment: @resident.apartment
      )

      discarded_apartment = @resident.apartment.block.apartments.find_by!(name: 'discarded')
      @resident.update!(apartment: discarded_apartment) 
    end

    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Resident was successfully archived.' }
      format.json { head :no_content }
    end

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.html { redirect_to residents_url, alert: "Error archiving resident: #{e.message}" }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end



  private

  def create_rent_session(resident)
    rent_sessions = RentSession.kept.filter_by_admin(current_user).with_in_current_month
    paymentDueDate = Time.zone.today.change(day: resident.startdate.day)
    paymentDueDate += 1.month if paymentDueDate < Time.zone.today
    if rent_sessions.empty?
      RentSession.create(
        paymentDueDate:,
        resident:,
        apartment: resident.apartment,
        amount: resident.apartment.price
      )
    else
      rent_sessions.first
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_resident
    @resident = Resident.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def resident_params
    params.require(:resident).permit(
      :name,
      :physicalId,
      :phonenumber,
      :apartment_id,
      :startdate
    )
  end

  def payment_params
    params.require(:payment).permit(:date, :amount)
  end
end
