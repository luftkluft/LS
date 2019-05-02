class SequrityRoutesService
  BLACK_ROUTES = %w[/users/sign_up /users/edit].freeze
  def initialize
    @errors = []
  end

  def check_route(route)
    if check_black_routes(route)
      nil
    else
      @errors.push(I18n.t('services.check_black_routes.error'))
      @errors
    end
  rescue StandardError
    @errors.push(I18n.t('services.check_routes.error'))
    @errors
  end

  private

  def check_black_routes(route)
    black_routes.each do |phrase|
      return false if route == phrase
    end
    true
  rescue StandardError
    @errors.push(I18n.t('services.check_routes.error'))
  end

  def black_routes
    BLACK_ROUTES
  end
end
