class UsersController < ApplicationController
  STATUS_UNPROCESSABLE_ENTITY = :unprocessable_entity
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.paginate(page: params[:page], per_page: 10)
  end

  def show
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash[:danger] = "Sign up error!!!"
      render "new", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to(root_url) if !current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) if !current_user.admin?
    end
end
