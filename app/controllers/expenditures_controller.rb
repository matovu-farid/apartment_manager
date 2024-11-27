# frozen_string_literal: true

class ExpendituresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expenditure, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /expenditures or /expenditures.json
  def index
    if Block.filter_by_admin(current_user).empty?
      redirect_to(new_block_path)
    elsif  @expenditures.empty? && !params[:start_date].present?
      redirect_to(new_expenditure_path)
    end

    @expenditures = Expenditure.accessible_by(current_ability)
    if params["start_date(1i)"].present? && params["end_date(1i)"].present?

      @start_date = Date.new(
        params["start_date(1i)"].to_i,
        params["start_date(2i)"].to_i,
        params["start_date(3i)"].to_i
      )
      @end_date = Date.new(
        params["end_date(1i)"].to_i,
        params["end_date(2i)"].to_i,
        params["end_date(3i)"].to_i
      )
     
      @expenditures = @expenditures.filter_by_date(
        @start_date,
        @end_date
      )
    end
    
    @expenditures = @expenditures.order(date: :desc)
    

  end

  # GET /expenditures/1 or /expenditures/1.json
  def show; end

  # GET /expenditures/new
  def new
    @expenditure = Expenditure.new
    @categories = Expenditure.group(:category)
                           .order('count_id DESC')
                           .limit(20)
                           .count(:id)
                           .keys
                    
  
  end

  # GET /expenditures/1/edit
  def edit
    @categories = Expenditure.group(:category)
                           .order('count_id DESC')
                           .limit(20)
                           .count(:id)
                           .keys
  end

  # POST /expenditures or /expenditures.json
  def create
    # Remove non-numeric characters from amount
    expenditure_params[:amount].gsub!(/[^0-9]/, '') if expenditure_params[:amount].present?

    @expenditure = Expenditure.new(expenditure_params)
    @categories = Expenditure.group(:category)
                           .order('count_id DESC')
                           .limit(20)
                           .count(:id)
                           .keys

    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to(expenditure_url(@expenditure), notice: "#{@expenditure.name} was successfully created.") }
        format.json { render(:show, status: :created, location: @expenditure) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @expenditure.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /expenditures/1 or /expenditures/1.json
  def update
    # Remove non-numeric characters from amount
    expenditure_params[:amount].gsub!(/[^0-9]/, '') if expenditure_params[:amount].present?

    @categories = Expenditure.group(:category)
                           .order('count_id DESC')
                           .limit(20)
                           .count(:id)
                           .keys
    
    respond_to do |format|
      if @expenditure.update(expenditure_params)
        format.html { redirect_to(expenditure_url(@expenditure), notice: "#{@expenditure.name} was successfully updated.") }
        format.json { render(:show, status: :ok, location: @expenditure) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @expenditure.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /expenditures/1 or /expenditures/1.json
  def destroy
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to(expenditures_url, notice: "#{@expenditure.name} was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expenditure
    @expenditure = Expenditure.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expenditure_params
    params.require(:expenditure).permit(:date, :name, :reference, :description, :amount, :category, :block_id)
  end
end
