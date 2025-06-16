class UsersController < ApplicationController
  before_action :set_user, only: [ :show ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      flash[:danger] = "Sign up error!!!"
      # unprocessable_entity is the status code for validation failed (422)
      render "new", status: :unprocessable_entity
    end
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
