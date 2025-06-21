class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.paginate(page: params[:page], per_page: 10)
  end

  def show
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t("users.create.check_email")
      redirect_to root_url
    else
      flash[:danger] = t("users.create.signup_error")
      render "new", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t("users.update.profile_updated")
      redirect_to @user
    else
      render "edit", status: STATUS_UNPROCESSABLE_ENTITY
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t("users.destroy.user_deleted")
    redirect_to users_url
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      redirect_to(root_url) if !current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) if !current_user.admin?
    end
end
