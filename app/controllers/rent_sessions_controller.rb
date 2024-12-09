# frozen_string_literal: true

class RentSessionsController < ApplicationController
  include Payable
  before_action :authenticate_user!
  before_action :set_rent_session, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /rent_sessions or /rent_sessions.json
  def index
    @rent_sessions = RentSession.kept.filter_by_admin(current_user)
    return unless @rent_sessions.empty?

    redirect_to(new_rent_session_path)
  end

  def renew_rent
    @rent_sessions = RentSession.kept.filter_by_admin(current_user)
    prev_month_start = (Time.zone.today.beginning_of_month - 1.month).beginning_of_month
    prev_month_start.end_of_month
    prev_month_sessions = @rent_sessions.where(paymentDueDate: prev_month_start..prev_month_start.end_of_month)
    prev_month_sessions.each do |rent_session|
      new_rent_session = rent_session.dup
      new_rent_session.paymentDueDate += 1.month
      new_rent_session.save
    end

    redirect_back(fallback_location: root_path)
  end

  # GET /rent_sessions/1 or /rent_sessions/1.json
  def show; end

  # GET /rent_sessions/new
  def new
    @rent_session = RentSession.new
    if Resident.kept.filter_by_admin(current_user).empty?
      redirect_to(new_resident_path)
      return
    end

    return unless Apartment.filter_by_admin(current_user).empty?

    redirect_to(new_apartment_path)
  end

  # GET /rent_sessions/1/edit
  def edit; end

  # POST /rent_sessions or /rent_sessions.json
  def create
    @rent_session = RentSession.new(rent_session_params)

    respond_to do |format|
      if @rent_session.save
        format.html { redirect_to(rent_session_url(@rent_session), notice: 'Rent session was successfully created.') }
        format.json { render(:show, status: :created, location: @rent_session) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @rent_session.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /rent_sessions/1 or /rent_sessions/1.json
  def update
    respond_to do |format|
      if @rent_session.update(rent_session_params)
        format.html { redirect_to(rent_session_url(@rent_session), notice: 'Rent session was successfully updated.') }
        format.json { render(:show, status: :ok, location: @rent_session) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @rent_session.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /rent_sessions/1 or /rent_sessions/1.json
  def destroy
    @rent_session.destroy

    respond_to do |format|
      format.html { redirect_to(rent_sessions_url, notice: 'Rent session was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rent_session
    @rent_session = RentSession.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rent_session_params
    params.require(:rent_session).permit(:paymentDueDate, :resident_id, :apartment_id)
  end
end
