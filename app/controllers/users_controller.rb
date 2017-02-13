class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :new]
  before_action :correct_or_admin_user,    only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create, :new]
   
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end  
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to login_path and return unless @user.activated?
  end
  
  def new
  	@user = User.new
  end
  
	def create
    @user = User.new(user_params)
    @user.update_attributes(password: user_params[:temporary_password])
    if @user.save
    	@user.update_attributes(temporary_active: true)
    	@user.send_activation_email
    	flash[:info] = "An email for account activation has been sent to the user"
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
    	if @user.temporary_active
    		@user.update_attribute(:temporary_active, 'false')
    	end
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :temporary_password)
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