class AccountActivationsController < ApplicationController

  #Access account needs to be activated by the mailer. This is artifact code from when the access accounts
  #were made using the GUI. Now they can only be made via console./

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to login_path
    end
  end
end