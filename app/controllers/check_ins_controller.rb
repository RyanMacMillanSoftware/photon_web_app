class CheckInsController < ApplicationController

  before_action :admin_user
  before_action :microfab_access
	
	def destroy
    @check_in = CheckIn.find(params[:id])
    @check_in.delete
    flash[:success] = "Check in deleted"
    redirect_to microfab_path
  end  
	
	def edit
   
   @check_in = CheckIn.find(params[:id])
   
   
   	
  end
  
   def update
   	@check_in = CheckIn.find(params[:id])
   	form_time = DateTime.current
   	form_time = form_time.change({hour: params[:check_in][:'time(4i)'].to_i, min: params[:check_in][:'time(5i)'].to_i})
 		if DateTime.current < form_time
   		flash[:danger] = "You can not set the time to the future"
   		render 'edit'
   		return
   	end
   	@check_in.name = params[:check_in][:name]
   	@check_in.time = @check_in.time.change({hour: params[:check_in][:'time(4i)'], min: params[:check_in][:'time(5i)']})
   	@check_in.buddy = params[:check_in][:buddy]
  		if  @check_in.save
      	flash[:success] = "Time punch successfully changed"
      	redirect_to microfab_path
 
    	else
    		flash[:danger] = "Invalid. This person may already be punched in"
      	render 'edit'
    	end
  end

	
	
	private

    # Before filters

    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(root_url)
      else
      	redirect_to(root_url) unless current_user.admin?
      end
    end
    
	# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
     
    # Confirms a user with microfab access.
    def microfab_access
      if current_user.nil?
      	redirect_to(root_url)
      else
      	redirect_to(root_url) unless current_user.microfab?
      end
    end

end
