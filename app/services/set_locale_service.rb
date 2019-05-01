class SetLocaleService
  def initialize
    @errors = []
  end

  def set_current_locale(current_user, home_params)
    current_user.update(current_locale: home_params[:current_locale])
    nil
  rescue StandardError
    @errors.push(I18n.t('services.set_locale.error'))
  end
end
