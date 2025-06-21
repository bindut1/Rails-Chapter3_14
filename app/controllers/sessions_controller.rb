class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        handle_remember_me @user
        redirect_back_or @user
      else
        message = t("sessions.create.account_not_activated")
        message += t("sessions.create.check_email_for_activation")
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t("sessions.create.invalid_email_password")
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def handle_remember_me(user)
      remember_me_checked? ? remember(user) : forget(user)
    end

    def remember_me_checked?
      params.dig(:session, :remember_me) == "1"
    end
end
