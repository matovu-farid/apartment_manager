# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_resident, only: %i[show edit update destroy new create index]
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /payments or /payments.json
  def index
    if @resident.nil?
      @q = Payment.accessible_by(current_ability).ransack(params[:q])
      @payments = @q.result(distinct: true).includes(:resident)
      @rent_session = nil
    else
      @q = @resident.payments.accessible_by(current_ability).ransack(params[:q])
      @payments = @q.result(distinct: true)
      @rent_session = @resident.find_or_create_current_rent_session
    end
  end


  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @residents = Resident.accessible_by(current_ability)
    if @resident
      @rent_session = @resident.find_or_create_current_rent_session
    end
  end

  # GET /payments/1/edit
  def edit
    @resident = Resident.find(params[:resident_id])
    @rent_session = @resident.find_or_create_current_rent_session
  end

  # POST /payments or /payments.json
  def create
    @payment = init_payment
    respond_to do |format|
      if @payment.save
        if @resident
          format.html { redirect_to(resident_payments_path(@resident), notice: "Payment was successfully created.")}
        else
          format.html { redirect_to(payments_path, notice: "Payment was successfully created.")}
        end
        format.json { render(:show, status: :created, location: @payment) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @payment.errors, status: :unprocessable_entity) }
      end
    end
  end

  def receipt
    @payment = Payment.find(params[:payment_id])
    @resident = @payment.resident
    @rent_session = @resident.find_or_create_current_rent_session
    @block = @resident.apartment.block
    @apartment = @resident.apartment
    @user = current_user

    respond_to do |format|
      format.html { render("payments/receipt", status: :ok) }

    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to(resident_payments_url(@resident), notice: "Payment was successfully updated.") }
        format.json { render(:show, status: :ok, location: @payment) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @payment.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to(resident_payments_url, notice: "Payment was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_resident
    @resident = nil
    return unless params[:resident_id]

    @resident = Resident.find(params[:resident_id])
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:date, :amount)

  end

  def init_payment
    if params[:resident_id]
      resident = Resident.find(params[:resident_id])
    else
      resident = Resident.find(params[:payment][:resident_id])
    end


    payment = Payment.new(date: payment_params[:date], amount: payment_params[:amount])
    rent_session = resident.find_or_create_current_rent_session
    payment.rent_session = rent_session
    payment
  end
end
