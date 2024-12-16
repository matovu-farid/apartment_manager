# frozen_string_literal: true

class ExpendituresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expenditure, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /expenditures or /expenditures.json
  def index
    @q = Expenditure.accessible_by(current_ability).ransack(params[:q])
    @expenditures = @q.result(distinct: true)
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
