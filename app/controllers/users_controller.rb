#handles Access accounts that can login from anywhere!
class UsersController < ApplicationController

  before_action :logged_in_user

  before_action :correct_or_admin_user
   
	  
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

    #trying to remove "microfab" user attribute. this code block should go!
    if params[:user][:microfab] == true
    	admin_user
    end

    if @user.update_attributes(user_params)	
    	@user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


   private

    def temp_user_params
      params.require(:user).permit(:name, :email, :temporary_password)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


    # Before filters
    
    # Confirms a logged-in user.
     def logged_in_user
       unless logged_in?
       	store_location
         flash[:danger] = "Please log in."
         redirect_to login_url
       end
     end
     
      # Confirms the correct user or an admin.
     def correct_or_admin_user
       
       @user = User.find(params[:id])
       if current_user.nil?
       	redirect_to(root_url)
       else
       	redirect_to(root_url) unless current_user.admin? | current_user?(@user)
       end
     end 
     
    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(root_url)
      else
      	redirect_to(root_url) unless current_user.admin?
      end
    end
end