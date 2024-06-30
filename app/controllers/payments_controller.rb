class PaymentsController < ApplicationController
  before_action :set_resident, only: %i[show edit update destroy new create index]
  before_action :set_payment, only: %i[show edit update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /payments or /payments.json
  def index
    @payments = Payment.filter_by_admin(current_user)
    if @payments.empty?
      redirect_to(residents_url)
    end

    @rent_session = create_rent_session(@resident)
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new

    @payment = Payment.new
    @rent_session = create_rent_session(@resident)
  end

  # GET /payments/1/edit
  def edit

    @resident = Resident.find(params[:resident_id])
    @rent_session = create_rent_session(@resident)
  end

  # POST /payments or /payments.json
  def create
    @resident = Resident.find(params[:resident_id])

    @payment = Payment.new(payment_params)

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

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html {
          redirect_to(resident_payments_url(@resident), notice: "Payment was successfully updated.")
        }
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
    if params[:resident_id]
      @resident = Resident.find(params[:resident_id])
    end
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:date, :amount)
  end

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
end
