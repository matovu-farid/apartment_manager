class ApartmentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_apartment, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /apartments or /apartments.json
  def index
    @apartments = Apartment.accessible_by(current_ability)
    if Block.filter_by_admin(current_user).empty?
      redirect_to(new_block_path)
    elsif @apartments.empty?
      redirect_to(new_apartment_path)
    end
  end

  # GET /apartments/1 or /apartments/1.json
  def show
  end

  # GET /apartments/new
  def new
    @apartment = Apartment.new
    if Block.filter_by_admin(current_user).empty?
      redirect_to(new_block_path)
    end
  end

  # GET /apartments/1/edit
  def edit
  end

  # POST /apartments or /apartments.json
  def create
    # replace non numberic
    apartment_params[:price].gsub!(/[^0-9]/, "")

    @apartment = Apartment.new(apartment_params)

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to(apartment_url(@apartment), notice: "Apartment was successfully created.") }
        format.json { render(:show, status: :created, location: @apartment) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @apartment.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /apartments/1 or /apartments/1.json
  def update

    apartment_params[:price].gsub!(/[^0-9]/, "")

    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to(apartment_url(@apartment), notice: "Apartment was successfully updated.") }
        format.json { render(:show, status: :ok, location: @apartment) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @apartment.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /apartments/1 or /apartments/1.json
  def destroy
    @apartment.destroy

    respond_to do |format|
      format.html { redirect_to(apartments_url, notice: "Apartment was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def apartment_params
    params.require(:apartment).permit(:price, :floor, :name, :block_id)
  end
end
