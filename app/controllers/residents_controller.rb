class ResidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resident, only: %i[show edit update destroy]
  include Payable

  load_and_authorize_resource
  # GET /residents or /residents.json
  def index
    @residents = Resident.accessible_by(current_ability)
    if @residents.empty?
      redirect_to(new_resident_path)
    end
  end

  # GET /residents/1 or /residents/1.json
  def show
  end

  # GET /residents/new
  def new
    @resident = Resident.new
    if Apartment.accessible_by(current_ability).where(isOccupied: false).empty?
      redirect_to(new_apartment_path)
    end
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents or /residents.json
  def create

    @resident = Resident.new(resident_params)
    apartment = Apartment.find(@resident.apartment_id)
    apartment.isOccupied = true
    rent_session = RentSession.new(paymentDueDate: @resident.startdate, resident: @resident, apartment: apartment)

    begin
      ActiveRecord::Base.transaction do
        @resident.save!
        rent_session.save!
        apartment.save!
      end

      respond_to do |format|
        format.html { redirect_to(resident_url(@resident), notice: "Resident was successfully created.") }
        format.json { render(:show, status: :created, location: @resident) }
      end

    rescue ActiveRecord::RecordInvalid => e
      format.html { render(:new, status: :unprocessable_entity) }
      format.json { render(json: @resident.errors, status: :unprocessable_entity) }
    end
  end

  def setup_payment
    @resident = Resident.find(params[:resident_id])
    redirect_to(resident_payments_path(@resident))
  end

  def add_payment

    @resident = Resident.find(params[:resident_id])

    @payment = Payment.new({date: params[:date], amount: params[:amount]})

    @rent_session = create_rent_session(@resident)

    @payment.rent_session = @rent_session

    respond_to do |format|
      if @payment.save
        format.html {
          redirect_to(residents_path, notice: "Payment was successfully created.")
        }
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
        format.html { redirect_to(resident_url(@resident), notice: "Resident was successfully updated.") }
        format.json { render(:show, status: :ok, location: @resident) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @resident.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /residents/1 or /residents/1.json
  def destroy
    @resident.destroy

    respond_to do |format|
      format.html { redirect_to(residents_url, notice: "Resident was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  def create_rent_session(resident)
    rent_sessions = RentSession.filter_by_admin(current_user).with_in_current_month
    paymentDueDate = Date.today.change(day: resident.startdate.day)
    paymentDueDate = paymentDueDate + 1.month if paymentDueDate < Date.today
    rent_session = nil
    if rent_sessions.empty?
      rent_session = RentSession.create(
        paymentDueDate: paymentDueDate,
        resident: resident,
        apartment: resident.apartment
      )
    else
      rent_session = rent_sessions.first
    end

    rent_session
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
