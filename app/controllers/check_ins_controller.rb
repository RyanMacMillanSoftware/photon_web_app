class CheckInsController < ApplicationController

  #CheckIns are created and stored while a user is in the lab. The data from a CheckIn is used to
  #create a TimePunch when they log out. The creation of CheckIns is handled by the TimePunch controller (I know this is bad)/
	before_action :logged_in_user
  
  #Called when the "log out" button on the CheckIn table is pressed/
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


	
	private

    # Before filters

	# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
      	store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
end
