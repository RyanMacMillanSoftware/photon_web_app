class UsersController < ApplicationController

  before_action :admin_user
   
  
  
 
  def show
    @user = User.find(params[:id])
    redirect_to login_path and return unless @user.activated?
  end
  
  
  
  def edit
    @user = User.find(params[:id])
  end
  
   def update
    @user = User.find(params[:id])
    if params[:user][:microfab] == true
    	admin_user
    end
    if @user.update_attributes(user_params)
    	if @user.temporary_active?
    		@user.temporary_active = false
    	end
    	@user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


   private

    def temp_user_params
      params.require(:user).permit(:name, :email, :temporary_password, :microfab)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :microfab)
    end


    # Before filters
    
    
    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(root_url)
      else
      	redirect_to(root_url) unless current_user.admin?
      end
    end
end