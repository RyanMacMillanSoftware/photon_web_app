class PrinterDataController < ApplicationController
	#The ugliest controller in the codebase
#Creates CheckIns, turns CheckIns into TimePunches. 


	
	before_action :logged_in_user
   
	def new
  		@printer_data = PrinterDatum.new
	end
  

	def create
		
	end

	def index

	end

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
 

end
