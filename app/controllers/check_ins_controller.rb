class CheckInsController < ApplicationController

  before_action :microfab_access
	
	def destroy
    @check_in = CheckIn.find(params[:id])
    time_punch = TimePunch.new(name: @check_in.name)
    time_punch.save
    time_punch.do_check_in @check_in
    time_punch.do_check_out
    	@check_in.delete
		flash[:success] = "Successfully logged out"
		redirect_to root_path
  

  end

	def expire_after_midnight
		CheckIn.delete_all
		#INSERT MAILER CODE HERE
	end
		handle_asynchronously :expire_after_midnight, :run_at => Proc.new { Time.now.change(hour: 23, min: 59, sec:59) }
	
	
	private

    # Before filters

    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(login_path)
      else
      	redirect_to(login_path) unless current_user.admin?
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
      	redirect_to(login_path)
      else
      	redirect_to(login_path) unless current_user.microfab?
      end
    end

end
