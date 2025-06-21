class PasswordResetsController < ApplicationController
  STATUS_UNPROCESSABLE_ENTITY = :unprocessable_entity
  before_action :get_user, :valid_user, :check_expiration, only: [ :edit, :update ]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render "new", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render "edit", status: STATUS_UNPROCESSABLE_ENTITY
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render "edit", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      if !@user || !@user.authenticated?(:reset, params[:id])
        redirect_to root_url
      elsif !@user.activated?
        flash[:danger] = "Account not activated. Please activate your account before resetting your password."
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
