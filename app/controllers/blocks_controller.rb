class BlocksController < ApplicationController
  before_action :set_block, only: %i[show edit update destroy]

  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /blocks or /blocks.json
  def index
    @blocks = Block.filter_by_admin(current_user)

    # redirect to create block if no blocks exist
    if @blocks.empty?
      redirect_to(new_block_path)
    end
  end

  # GET /blocks/1 or /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks or /blocks.json
  # def create
  #   @block = Block.new(block_params)
  #   @block_admin = BlockAdmin.new(user: current_user, block: @block)
  #   @block_key = BlockKey.new(block: @block)
  #   respond_to do |format|
  #     if @block.save && @block_admin.save && @block_key.save
  #       format.html { redirect_to(block_url(@block), notice: "Block was successfully created.") }
  #       format.json { render(:show, status: :created, location: @block) }
  #     else
  #       format.html { render(:new, status: :unprocessable_entity) }
  #       format.json { render(json: @block.errors, status: :unprocessable_entity) }
  #     end
  #   end
  # end

  def create
    @block = Block.new(block_params)
    @block_admin = BlockAdmin.new(user: current_user, block: @block)
    @block_key = BlockKey.new(block: @block)

    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @block.save!
          @block_admin.save!
          @block_key.save!
          format.html { redirect_to(block_url(@block), notice: "Block was successfully created.") }
          format.json { render(:show, status: :created, location: @block) }
        end

      rescue ActiveRecord::RecordInvalid => e
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: e.record.errors, status: :unprocessable_entity) }
      end
    end
  end
  # PATCH/PUT /blocks/1 or /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to(block_url(@block), notice: "Block was successfully updated.") }
        format.json { render(:show, status: :ok, location: @block) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @block.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /blocks/1 or /blocks/1.json
  def destroy
    @block.destroy

    respond_to do |format|
      format.html { redirect_to(blocks_url, notice: "Block was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  def pull
    @block_key = BlockKey.find_by(key: params[:key])
    @block = @block_key.block
    @block_admin = BlockAdmin.new(user: current_user, block: @block)
    if @block_admin.save do
        redirect_to(block_url(@block), notice: "You are now an admin for #{block.name}")
      else

        redirect_to(blocks_url, notice: "Block was not successfully pulled.")
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_block
    @block = Block.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def block_params
    params.require(:block).permit(:name, :user_id)
  end
end
