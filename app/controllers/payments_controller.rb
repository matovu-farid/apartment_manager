class PaymentsController < ApplicationController
  before_action :set_rent_session
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
    if @payments.empty?
      redirect_to(rent_sessions_url)
    end
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    @rent_session = @payment.rent_session
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.rent_session = @rent_session
    respond_to do |format|
      if @payment.save
        format.html {
          redirect_to(rent_session_payment_url([@rent_session, @payment]), notice: "Payment was successfully created.")
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
          redirect_to(rent_session_payment_url([@rent_session, @payment]), notice: "Payment was successfully updated.")
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
      format.html { redirect_to(rent_session_payments_url, notice: "Payment was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rent_session
    @rent_session = nil
    if params[:rent_session_id]
      @rent_session = RentSession.find(params[:rent_session_id])
    end
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:date, :amount)
  end
end
