class PrinterDataController < ApplicationController
	#The ugliest controller in the codebase
#Creates CheckIns, turns CheckIns into TimePunches. 


	
	before_action :logged_in_user
   
	def new
  		@printer_data = PrinterDatum.new
	end
  

	def create
    hour =  params[:'hour'].to_i
    if params[:'meridian'] == "PM"
      hour = hour + 12
    end
    to_time = DateTime.now.change(hour: hour, min: params[:'minute'].to_i, sec: 59)
   		@printer_data = PrinterDatum.new(name: params[:printer_datum][:'name'], project: params[:printer_datum][:'project'], printer:params[:printer_datum][:'printer'], phonenumber: params[:printer_datum][:'phonenumber'], volume: params[:printer_datum][:'volume'], notes: params[:printer_datum][:'notes'], from_time: DateTime.now, to_time: to_time)
    	if @printer_data.save
        #update printer status
        printer = PrinterStatus.find_by(printer: @printer_data.printer)
        printer.update_attributes(available: false, completion_time: to_time)
    		flash[:success] = "Data Stored Successfully"
    		redirect_to printer_statuses_path
    	else
      		render 'new'
      	end
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
