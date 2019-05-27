module RoomsHelper
  def user_image(room_message)
    image_tag User.find(room_message.user_id).image.url, class: 'avatar'
  end
end
