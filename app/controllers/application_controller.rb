class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend
  protect_from_forgery prepend: true
  before_action :check_routes
  before_action :set_locale
  add_flash_types :success, :danger, :info, :warning
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_locale
    I18n.locale = current_user.try(:current_locale) || I18n.default_locale
  end

  def check_routes
    errors = SequrityRoutesService.new.check_route(request.fullpath)
    errors&.each do |error|
      flash[:danger] = error
      redirect_to root_path
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:danger] = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default
    redirect_to(request.referrer || root_path)
  end
end
