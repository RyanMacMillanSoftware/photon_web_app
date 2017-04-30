class CheckInsController < ApplicationController

  before_action :admin_user
  before_action :microfab_access
	
	def destroy
    @check_in = CheckIn.find(params[:id])
    time_punch = TimePunch.new(name: @check_in.name)
    time_punch.save
    time_punch.do_check_in @check_in
    time_punch.do_check_out
    	@check_in.delete
		flash[:success] = "Successfully logged out"
		redirect_to microfab_path
  

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
