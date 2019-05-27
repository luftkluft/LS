class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entities

  def index
    @rooms = Room.all
  end

  def show
    @rooms = Room.all
    crypter = CryptMessageService.new
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user).order('created_at DESC')
    @room_messages = crypter.decypted_messages(@room_messages)
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    authorize @room
    if @room.save
      redirect_to rooms_path, success: t('rooms.success_create')
    else
      flash.now[:danger] = t('rooms.failed_create')
      render :new
    end
  end

  def edit
    authorize @room
  end

  def update
    authorize @room
    if @room.update_attributes(room_params)
      redirect_to rooms_path, success: t('rooms.success_update')
    else
      flash.now[:danger] = t('rooms.failed_update')
      render :edit
    end
  end

  def destroy
    authorize @room
  end

  protected

  def load_entities
    @room = Room.find(params[:id]) if params[:id]
  rescue StandardError
    redirect_to rooms_path
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
