class UserMailer < ApplicationMailer
  default from: 'LightSoft application'

  def welcome_email(user)
    @user = user
    # @url  = 'https://ls2019.herokuapp.com/users/sign_in'
    @url = 'https://test_link.test'
    mail(to: @user.email, subject: 'Welcome to LightSoft!')
  end
end
