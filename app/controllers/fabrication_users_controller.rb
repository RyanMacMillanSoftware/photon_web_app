#These are the users that can log in and out of the lab. Admins need a microfabuser account to if they
#plan on using the lab. These accounts do not give access. They just fill the form dropdown menus. 
class FabricationUsersController < ApplicationController
  respond_to :json, :html, only: :show
   #admins can manage microgab users in the "Users" tab/
  before_action :admin_user
  
  def show
    @f_user = FabricationUser.find_by(name: params[:name])
    if @f_user.number != nul
      respond_with @f_user.number
    else
      respont_with ""
  end

  #delete the user
  def destroy
    FabricationUser.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to fabrication_users_url
  end  
  
  #show the mfusers in a paginate format in the "Users" tab
  def index
    @f_users = FabricationUser.order(:name).paginate(page: params[:page])
  end

  def show
    @f_user = FabricationUser.find(params[:id])
  end
  
  def new
  	@f_user = FabricationUser.new
  end
  
	def create
    @f_user = FabricationUser.new(fuser_params)
     if @f_user.save
    	flash[:success] = "User created"
      redirect_to fabrication_users_path
    else
      render 'new'
    end
  end
  
  def edit
    @f_user = FabricationUser.find(params[:id])
  end
  
   def update
    @f_user = FabricationUser.find(params[:id])
    #if attributes are valid and they save then update/
    if @f_user.update_attributes(fuser_params)
    	@f_user.save
      flash[:success] = "User updated"
      redirect_to fabrication_users_path
    #otherwise render the edit page again for reentry/
    else
      render 'edit'
    end
  end


   private

    def fuser_params
      params.require(:fabrication_user).permit(:name, :email)
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
