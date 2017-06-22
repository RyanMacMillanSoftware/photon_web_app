#This handles the "Download Spreadsheet". You use a seleciton of dates to specify the data to download./
require 'rubygems'
require 'spreadsheet'

class SelectionsController < ApplicationController
	#require 'spreadsheet'
	before_action :logged_in_user
   before_action :admin_user
   
  
  
  #use the form to get the start and end dates for downloading data
  def create
  	
  	@selection = Selection.new
  	if params[:selection][:'from_time(1i)'].present? & params[:selection][:'from_time(2i)'].present? & params[:selection][:'from_time(3i)'].present? & params[:selection][:'to_time(1i)'].present? & params[:selection][:'to_time(2i)'].present? & params[:selection][:'to_time(3i)'].present?   
  		
  		@selection.from_time = DateTime.new(params[:selection][:'from_time(1i)'].to_i, params[:selection][:'from_time(2i)'].to_i,
  									(params[:selection][:'from_time(3i)'].to_i),0,0,0,"+13:00")
  		@selection.to_time= DateTime.new(params[:selection][:'to_time(1i)'].to_i, params[:selection][:'to_time(2i)'].to_i,
  									params[:selection][:'to_time(3i)'].to_i, 23,59,59,"+13:00")
  		if params[:selection][:name].present?
  			@selection.name = params[:selection][:name]
  		end
      #If the selection is valid, then just download it!
  		if @selection.save
  			download_data
        #after downloading, you can not redirect. the page looses all functionality at this point. would be a
        #nice fix
  		else
  			render 'new'
  		end
  	else
  		Selection.delete_all
  		flash[:danger] = "Missing field"
		render 'new'
  	end
  end


  def new
  	@selection = Selection.new
  end
  
	

   private

    # Before filters

    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(login_path)
      else
      	redirect_to(root_path) unless current_user.admin?
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
    def download_data
    	Spreadsheet.client_encoding = 'UTF-8'
			book = Spreadsheet::Workbook.new
 	 		sheet1 = book.create_worksheet 
 	 		sheet1.name = "Time Punches #{Selection.first.from_time} - #{Selection.first.to_time}"
 	 		
 	 		#formatting
 	 		date_time = Spreadsheet::Format.new :number_format => 'DD/MM/YYYY hh:mm:ss'
 	 		sheet1.column(1).default_format = date_time
 	 		sheet1.column(2).default_format = date_time
 	 		
 	 		bold = Spreadsheet::Format.new :weight => :bold
 	 		sheet1.row(0).default_format = bold
 	 		
 	 		
      //
 	 		sheet1.column(0).width = 20
 	 		sheet1.column(1).width = 20
 	 		sheet1.column(2).width = 30
 	 		sheet1.column(3).width = 30
 	 		sheet1.column(4).width = 20
 	 	
 	 		#content
 	 		sheet1.row(0).push 'Name', 'Buddy', 'DateTime In','DateTime Out', 'Minutes Elapsed'
 	 		all_tps = TimePunch.all
      sorted_all_tps_by_check_outs = all_tps.sort{ |a,b| a.check_out <=> b.check_out}
			selection = Selection.last 	 		
 	 		rownum = 1
      ##Print all guests
 	 		if selection.name == "Guest"
 	 			sorted_all_tps_by_check_outs.each do |time_punch|
 	 				if time_punch.guest && time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time
 	 					row = sheet1.row(rownum)
 	 					row.push "#{time_punch.name}"
 	 					if time_punch.buddy.nil? || time_punch.buddy.empty?
 	 						row.push "No buddy (Staff)"
 	 					else
 	 						row.push "#{time_punch.buddy}"
 	 					end
 	 					row.push "#{time_punch.check_in}"
						row.push "#{time_punch.check_out}"
						row.push "#{time_punch.seconds_elapsed}"
 	 					rownum += 1
 	 				end
 	 			end
      ##Print all for a specifed person	
 	 		elsif selection.name.present? 
 	 			sorted_all_tps_by_check_outs.each do |time_punch|
 	 				if time_punch.name == selection.name && time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time
 	 					row = sheet1.row(rownum)
 	 					row.push "#{time_punch.name}"
 	 					if time_punch.buddy.nil? || time_punch.buddy.empty?
 	 						row.push "No buddy (Staff)"
 	 					else
 	 						row.push "#{time_punch.buddy}"
 	 					end
 	 					row.push "#{time_punch.check_in}"
						row.push "#{time_punch.check_out}"
						row.push "#{time_punch.seconds_elapsed}"
 	 					rownum += 1
 	 				end
 	 			end
      ##Print all indiscrimatly
 	 		else 
 	 			sorted_all_tps_by_check_outs.each do |time_punch| 
 	 				if time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time	 				
 	 					row = sheet1.row(rownum)
 	 					row.push "#{time_punch.name}"
 	 					if time_punch.buddy.nil? || time_punch.buddy.empty? || time_punch.buddy == "Staff"
 	 						row.push "No buddy (Staff)"
 	 					else
 	 						row.push "#{time_punch.buddy}"
 	 					end
 	 					row.push "#{time_punch.check_in}"
						row.push "#{time_punch.check_out}"
						row.push "#{time_punch.seconds_elapsed}"
 	 					rownum += 1
 	 				end
 	 			end
 	 		end
 	 		
			
      #name file
  			@outfile = "Time_Punches_#{selection.from_time}_to_#{selection.to_time}.xls"
  			Selection.delete_all
  			
    		require 'stringio'
    		data = StringIO.new ''
        #write to book
    		book.write data
        #initiate download
    		send_data data.string, :type=>"application/excel", :disposition=>'attachment', :filename => @outfile
    end
   
end

