class PrinterDataController < ApplicationController

  before_action :logged_in_user
	before_action :fabrication_user
   
	def new
  		@printer_data = PrinterDatum.new
	end
  

	def create
    
    hour =  params[:'hour'].to_i
    if params[:'meridian'] == "PM"
      hour = hour + 12 unless hour == 12
    end
    to_time = DateTime.now.change(hour: hour, min: params[:'minute'].to_i, sec: 1)
   		
      if hour < DateTime.now.hour #tomorrow
        to_time = to_time.change(day: to_time.day+1)
        #completion_time = Time.new(Time.now.year, Time.now.month, Time.now.day+1, hour, params[:'minute'].to_i, 0)
        #else #today
        #completion_time = Time.new(Time.now.year, Time.now.month, Time.now.day, hour, params[:'minute'].to_i, 0)
      end

      @printer_data = PrinterDatum.new(name: params[:printer_datum][:'name'], project: params[:printer_datum][:'project'], phonenumber: params[:printer_datum][:'phonenumber'], volume: params[:printer_datum][:'volume'], notes: params[:printer_datum][:'notes'], from_time: DateTime.now, to_time: to_time)
    	
      @printer_data.printer = PrinterStatus.find(params[:printer]).printer
      if @printer_data.save
        #update printer status

        # completion today or tomorrow?
        
        printer = PrinterStatus.find_by(printer: @printer_data.printer)
        printer.update_attributes(available: false, completion_time: to_time, name: params[:printer_datum][:'name'], number: params[:printer_datum][:'phonenumber'])
    		flash[:success] = "Data Stored Successfully"
    		redirect_to printer_statuses_path
    	else
      	render 'new'
      end
	end

	
   private

    # Before filters

    # Confirms an fabrication user.
    def fabrication_user
      redirect_to(login_path) unless current_user.admin? || current_user.fabrication?
      
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
