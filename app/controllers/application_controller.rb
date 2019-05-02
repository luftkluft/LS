class ApplicationController < ActionController::Base
  before_action :check_routes
  before_action :set_locale

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
end
