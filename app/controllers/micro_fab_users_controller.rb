class MicroFabUsersController < ApplicationController

  before_action :admin_user
   
  def destroy
    MicroFabUser.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to microfabusers_url
  end  
  
  def index
    @mf_users = MicroFabUser.all.paginate(page: params[:page])
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
    	flash[:success] = "Account created"
      redirect_to @mf_user
    else
      render 'new'
    end
  end
  
  def edit
    @mf_user = MicroFabUser.find(params[:id])
  end
  
   def update
    @mf_user = MicroFabUser.find(params[:id])
    
    if @mf_user.update_attributes(mfuser_params)
    	@mf_user.save
      flash[:success] = "Profile updated"
      redirect_to @mf_user
    else
      render 'edit'
    end
  end


   private

    def mfuser_params
      params.require(:mf_user).permit(:name, :email)
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
