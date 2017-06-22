#Sessions are stored so that access users don't have to re log in upon exiting and reentering the browser
class SessionsController < ApplicationController

  def new
  end

  #create a session when you log in
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
     	 if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
     	 else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to login_path
       end
     else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
     end
  end

  #only end the session when the access user explicitly logs out
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
