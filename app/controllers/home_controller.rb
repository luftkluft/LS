class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index; end

  def set_current_locale
    errors = SetLocaleService.new.set_current_locale(current_user, home_params)
    errors&.each do |error|
      flash[:danger] = error
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def home_params
    params.permit(:current_locale)
  end
end
