class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :omniauthable, omniauth_providers: [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  # after_create :send_welcome_email
  mount_uploader :image, AvatarUploader

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
end
