class RoomMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entities

  def create
    crypter = CryptMessageService.new
    @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                       message: crypter.encrypted_data(params.dig(:room_message, :message))
    @room_message = crypter.decrypted_back(@room_message)
    flash.now[:danger] = crypter.errors.first if crypter.errors.any?
    RoomChannel.broadcast_to @room, @room_message
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  rescue StandardError
    redirect_to rooms_path
  end
end
