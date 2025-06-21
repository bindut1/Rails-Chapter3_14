class ApplicationController < ActionController::Base
  include SessionsHelper
  STATUS_UNPROCESSABLE_ENTITY = :unprocessable_entity

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  private
    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = t("application.logged_in_user.please_log_in")
        redirect_to login_url
      end
    end
end
