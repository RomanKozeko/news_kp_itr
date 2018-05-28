class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  add_flash_types :success, :danger
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
   redirect_to root_path, danger: "У вас нет прав доступа"
  end

  private

  def set_locale
    if current_user
      I18n.locale = current_user.locale.to_sym || I18n.default_locale
    else
      I18n.locale = :ru || I18n.default_locale
    end
  end

  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end
end
