# frozen_string_literal: true

class BlocksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_block, only: %i[show edit update destroy]

  # GET /blocks or /blocks.json
  def index
    @blocks = Block.accessible_by(current_ability)

    # redirect to create block if no blocks exist
    return unless @blocks.empty?

    redirect_to(new_block_path)
  end

  # GET /blocks/1 or /blocks/1.json
  def show; end

  # GET /blocks/new
  def new
    # @block = Block.new
  end

  # GET /blocks/1/edit
  def edit; end

  def create
    # @block.create
    @block_admin = BlockAdmin.new(user: current_user, block: @block)
    @block_key = BlockKey.new(block: @block)

    respond_to do |format|
      ActiveRecord::Base.transaction do
        @block.save!
        @block_admin.save!
        @block_key.save!
        format.html { redirect_to(block_url(@block), notice: 'Block was successfully created.') }
        format.json { render(:show, status: :created, location: @block) }
      end
    rescue ActiveRecord::RecordInvalid => e
      format.html { render(:new, status: :unprocessable_entity) }
      format.json { render(json: e.record.errors, status: :unprocessable_entity) }
    end
  end

  # PATCH/PUT /blocks/1 or /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to(block_url(@block), notice: 'Block was successfully updated.') }
        format.json { render(:show, status: :ok, location: @block) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @block.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /blocks/1 or /blocks/1.json

  def destroy
    if can?(:destroy, @block)
      begin
        ActiveRecord::Base.transaction do
          @block.remove_admin(current_user)
          admin_count = @block.admins.count
          @block.destroy if admin_count.zero?
        end

        respond_to do |format|
          format.html { redirect_to(blocks_url, notice: 'Block was successfully destroyed.') }
          format.json { head(:no_content) }
        end
      rescue StandardError => e
        respond_to do |format|
          format.html { redirect_to(blocks_url, alert: "Failed to destroy Block: #{e.message}") }
          format.json do
            render json: { error: "Failed to destroy Block: #{e.message}" }, status: :unprocessable_entity
          end
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to(blocks_url, alert: 'You are not authorized to perform this action.') }
        format.json { render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden }
      end
    end
  end

  def pull
    admin_key = BlockKey.find_by(key: params[:key])
    view_key = BlockKey.find_by(viewkey: params[:key])
    if admin_key.nil? && view_key.nil?
      respond_to do |format|
        format.html { redirect_to(blocks_url, notice: 'Block was not successfully pulled.') }
        format.json { render(json: { error: 'Block was not successfully pulled.' }, status: :unprocessable_entity) }
      end

      return
    end

    @block = admin_key.present? ? admin_key.block : view_key.block

    block_manager = if admin_key.present?
                      BlockAdmin.new(user: current_user, block: @block)
                    else
                      BlockViewer.new(
                        user: current_user,
                        block: @block
                      )
                    end

    respond_to do |format|
      if block_manager.save
        format.html { redirect_to(block_url(@block), notice: "You are now an admin for #{@block.name}") }
        format.json { render(:show, status: :created, location: @block) }
      else
        format.html { redirect_to(blocks_url, notice: 'Block was not successfully pulled.') }
        format.json { render(json: @block.errors, status: :unprocessable_entity) }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_block
    @block = Block.find(params[:id])
  end

  def initialize_block
    @block = Block.new
  end

  # Only allow a list of trusted parameters through.
  def block_params
    params.require(:block).permit(:name, :user_id)
  end
end
