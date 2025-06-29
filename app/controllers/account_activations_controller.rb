class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user&.can_be_activated?(params[:id])
      user.activate
      log_in user
      flash[:success] = t("account_activations.edit.account_activated")
      redirect_to user
    else
      flash[:danger] = t("account_activations.edit.invalid_activation_link")
      redirect_to root_url
    end
  end
end
