class PrinterSelectionsController < ApplicationController

	before_action :admin_user
	before_action :logged_in_user

	def new
		@p_selection=PrinterSelection.new
	end


	def create
		@p_selection = PrinterSelection.new
  		if params[:printer_selection][:'from_time(1i)'].present? & params[:printer_selection][:'from_time(2i)'].present? & params[:printer_selection][:'from_time(3i)'].present? & params[:printer_selection][:'to_time(1i)'].present? & params[:printer_selection][:'to_time(2i)'].present? & params[:printer_selection][:'to_time(3i)'].present?   
  		
  			@p_selection.from_time = DateTime.new(params[:printer_selection][:'from_time(1i)'].to_i, params[:printer_selection][:'from_time(2i)'].to_i,
  									(params[:printer_selection][:'from_time(3i)'].to_i),0,0,0,"+13:00")
  			@p_selection.to_time= DateTime.new(params[:printer_selection][:'to_time(1i)'].to_i, params[:printer_selection][:'to_time(2i)'].to_i,
  									params[:printer_selection][:'to_time(3i)'].to_i, 23,59,59,"+13:00")

        	#If the selection is valid, then just download it!
  			if @p_selection.save
  				download_printer_data
        	#after downloading, you can not redirect. the page looses all functionality at this point. would be a
        	#nice fix
  			else
  				render 'new'
  			end
  		else
  			PrinterSelection.delete_all
  			flash[:danger] = "Missing field"
			render 'new'
  		end
	end

   private

   

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

     #Handles the creation of the spreadsheet and then the download. uses the spreadsheet ruby gem
    def download_printer_data
    	Spreadsheet.client_encoding = 'UTF-8'
		book = Spreadsheet::Workbook.new
 	 	sheet1 = book.create_worksheet 
 	 	sheet1.name = "Printer Data #{PrinterSelection.last.from_time} - #{PrinterSelection.last.to_time}"
 	 	
 	 	#formatting
 	 	date_time = Spreadsheet::Format.new :number_format => 'DD/MM/YYYY hh:mm:ss'
 	 	sheet1.column(4).default_format = date_time
 	 	sheet1.column(5).default_format = date_time
 	 	
 	 	bold = Spreadsheet::Format.new :weight => :bold
 	 	sheet1.row(0).default_format = bold
 	 	 	 		
 	 	#name
 	 	sheet1.column(0).width = 20
 	 	#project
 	 	sheet1.column(1).width = 20
 	 	#printer
 	 	sheet1.column(2).width = 20
 	 	#volume
 	 	sheet1.column(3).width = 15
 	 	#date
 	 	sheet1.column(4).width = 20
 	 	#time taken
 	 	sheet1.column(5).width = 15
 	 	#notes
 	 	sheet1.column(6).width = 50
 	 	
 	 	#content
 	 	sheet1.row(0).push 'Name', 'Project', 'Printer', 'Volume','Date', 'Time Taken (m)', 'Notes'
 	 	all_data = PrinterDatum.all
    sorted_all_data = all_data.sort{ |a,b| a.to_time <=> b.to_time}
		selection = PrinterSelection.last 	 		
 	 	rownum = 1
    sorted_all_data.each do |data| 
 	 	  if data.from_time >= selection.from_time && data.to_time <= selection.to_time	 				
 	 	    row = sheet1.row(rownum)

        seconds = ((data.to_time - data.from_time)*24*60*60).to_i
        minutes = seconds / 60
        min = minutes % 60
        hours = minutes / 60
        hour = hours % 24
        time_taken = hour.to_s + 'Hours, '+ min.to_s + 'Mins'

 	 			row.push "#{data.name}"
 	 			row.push "#{data.project}"
 	 			row.push "#{data.printer}"
 	 			row.push "#{data.volume}"
 	 			row.push "#{data.from_time.strftime "%Y-%m-%d"}"
        row.push "#{time_taken}"
 	 			row.push "#{data.notes}"
        row.push "#{data.from_time}"
 	 			row.push "#{data.to_time}"
        rownum += 1
 	 		end
 	 	end
 	 	
      #name file
  		@outfile = "Printer_Data_#{selection.from_time.strftime "%Y-%m-%d"}_to_#{selection.to_time.strftime "%Y-%m-%d"}.xls"
  		PrinterSelection.delete_all
  		
    	require 'stringio'
    	data = StringIO.new ''
        #write to book
    	book.write data
        #initiate download
    	send_data data.string, :type=>"application/excel", :disposition=>'attachment', :filename => @outfile
    end
   
 

end
