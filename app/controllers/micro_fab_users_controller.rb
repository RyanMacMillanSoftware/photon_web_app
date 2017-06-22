#These are the users that can log in and out of the lab. Admins need a microfabuser account to if they
#plan on using the lab. These accounts do not give access. They just fill the form dropdown menus. 
class MicroFabUsersController < ApplicationController

   #admins can manage microgab users in the "Users" tab/
  before_action :admin_user
  

  #delete the user
  def destroy
    MicroFabUser.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to micro_fab_users_url
  end  
  
  #show the mfusers in a paginate format in the "Users" tab
  def index
    @mf_users = MicroFabUser.order(:name).paginate(page: params[:page])
  end

  def show
    @mf_user = MicroFabUser.find(params[:id])
  end
  
  def new
  	@mf_user = MicroFabUser.new
  end
  
	def create
    @mf_user = MicroFabUser.new(mfuser_params)
     if @mf_user.save
    	flash[:success] = "User created"
      redirect_to micro_fab_users_path
    else
      render 'new'
    end
  end
  
  def edit
    @mf_user = MicroFabUser.find(params[:id])
  end
  
   def update
    @mf_user = MicroFabUser.find(params[:id])
    #if attributes are valid and they save then update/
    if @mf_user.update_attributes(mfuser_params)
    	@mf_user.save
      flash[:success] = "User updated"
      redirect_to micro_fab_users_path
    #otherwise render the edit page again for reentry/
    else
      render 'edit'
    end
  end


   private

    def mfuser_params
      params.require(:micro_fab_user).permit(:name, :email)
    end


   
    
    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(login_path)
      else
      	redirect_to(login_path) unless current_user.admin?
      end
    end

end
