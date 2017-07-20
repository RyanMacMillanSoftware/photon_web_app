class PrinterDataController < ApplicationController
	#The ugliest controller in the codebase
#Creates CheckIns, turns CheckIns into TimePunches. 


	
	before_action :logged_in_user
   
	def new
  		@printer_data = PrinterDatum.new
	end
  

	def create
   		@printer_data = PrinterDatum.new(data_params)
      #set the date of the times to today
      @printer_data.from_time = Time.new(params[:printer_datum][:'from_time(1i)'], params[:printer_datum][:'from_time(2i)'], params[:printer_datum][:'from_time(3i)'], params[:printer_datum][:'from_time(4i)'], params[:printer_datum][:'from_time(5i)'], 0)
      @printer_data.to_time = Time.new(params[:printer_datum][:'to_time(1i)'], params[:printer_datum][:'to_time(2i)'], params[:printer_datum][:'to_time(3i)'], params[:printer_datum][:'to_time(4i)'], params[:printer_datum][:'to_time(5i)'], 59)
    	if @printer_data.save
    		flash[:success] = "Data Stored Successfully"
    		redirect_to new_printer_datum_path
    	else
      		render 'new'
      	end
	end

	
   private

    # Before filters

    def data_params
      params.require(:printer_datum).permit(:name, :project, :printer, :phonenumber,
                                   :from_time, :to_time, :volume, :notes)
    end

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
