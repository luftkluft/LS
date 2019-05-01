class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = current_user.try(:current_locale) || I18n.default_locale
  end
end
