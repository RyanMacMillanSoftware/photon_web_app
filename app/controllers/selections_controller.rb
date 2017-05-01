require 'rubygems'
require 'spreadsheet'

class SelectionsController < ApplicationController
	#require 'spreadsheet'
	before_action :logged_in_user
   before_action :admin_user
  
	before_action :microfab_access
   
  
  
  
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
  		if @selection.save
  			download_data
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
      	redirect_to(root_url)
      else
      	redirect_to(microfab_path) unless current_user.admin?
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
 	 		
 	 		
 	 		sheet1.column(0).width = 20
 	 		sheet1.column(1).width = 20
 	 		sheet1.column(2).width = 30
 	 		sheet1.column(3).width = 30
 	 		sheet1.column(4).width = 20
 	 	
 	 		#content
 	 		sheet1.row(0).push 'Name', 'Buddy', 'DateTime In','DateTime Out', 'Minutes Elapsed'
 	 		
			selection = Selection.last 	 		
 	 		rownum = 1
 	 		if selection.name == "Guest"
 	 			TimePunch.all.each do |time_punch|
 	 				if time_punch.guest && time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time
 	 					row = sheet1.row(rownum)
 	 					row.push "#{time_punch.name}"
 	 					row.push "#{time_punch.buddy}"
 	 					row.push "#{time_punch.check_in}"
						row.push "#{time_punch.check_out}"
						row.push "#{time_punch.seconds_elapsed}"
 	 					rownum += 1
 	 				end
 	 			end	
 	 		elsif selection.name.present? 
 	 			TimePunch.all.each do |time_punch|
 	 				if time_punch.name == selection.name && time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time
 	 					row = sheet1.row(rownum)
 	 					row.push "#{time_punch.name}"
 	 					row.push "#{time_punch.buddy}"
 	 					row.push "#{time_punch.check_in}"
						row.push "#{time_punch.check_out}"
						row.push "#{time_punch.seconds_elapsed}"
 	 					rownum += 1
 	 				end
 	 			end
 	 		elsif time_punch.check_in >= selection.from_time && time_punch.check_out <= selection.to_time
 	 			TimePunch.all.each do |time_punch| 	 				
 	 				row = sheet1.row(rownum)
 	 				row.push "#{time_punch.name}"
 	 				row.push "#{time_punch.buddy}"
 	 				row.push "#{time_punch.check_in}"
					row.push "#{time_punch.check_out}"
					row.push "#{time_punch.seconds_elapsed}"
 	 				rownum += 1
 	 			end
 	 		end
 	 		
			
  			@outfile = "Time_Punches_#{selection.from_time}_to_#{selection.to_time}.xls"
  			Selection.delete_all
  			
    		require 'stringio'
    		data = StringIO.new ''
    		book.write data
    		send_data data.string, :type=>"application/excel", :disposition=>'attachment', :filename => @outfile
    end
   
end

