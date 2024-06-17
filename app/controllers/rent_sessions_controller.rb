class RentSessionsController < ApplicationController
  before_action :set_rent_session, only: %i[ show edit update destroy ]

  # GET /rent_sessions or /rent_sessions.json
  def index
    @rent_sessions = RentSession.all
  end

  # GET /rent_sessions/1 or /rent_sessions/1.json
  def show
  end

  # GET /rent_sessions/new
  def new
    @rent_session = RentSession.new
  end

  # GET /rent_sessions/1/edit
  def edit
  end

  # POST /rent_sessions or /rent_sessions.json
  def create
    @rent_session = RentSession.new(rent_session_params)

    respond_to do |format|
      if @rent_session.save
        format.html { redirect_to rent_session_url(@rent_session), notice: "Rent session was successfully created." }
        format.json { render :show, status: :created, location: @rent_session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rent_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rent_sessions/1 or /rent_sessions/1.json
  def update
    respond_to do |format|
      if @rent_session.update(rent_session_params)
        format.html { redirect_to rent_session_url(@rent_session), notice: "Rent session was successfully updated." }
        format.json { render :show, status: :ok, location: @rent_session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rent_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rent_sessions/1 or /rent_sessions/1.json
  def destroy
    @rent_session.destroy

    respond_to do |format|
      format.html { redirect_to rent_sessions_url, notice: "Rent session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rent_session
      @rent_session = RentSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rent_session_params
      params.require(:rent_session).permit(:paymentDueDate, :resident_id, :apartment_id, :isPaid)
    end
end
