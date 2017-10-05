#The ugliest controller in the codebase
#Creates CheckIns, turns CheckIns into TimePunches. 

class TimePunchesController < ApplicationController
	
	before_action :logged_in_user
	before_action :microfab_user
   
  def new
  	@time_punch = TimePunch.new
  end
  

	def create
		
		#following is error handling. sorry this should be in the model. 
		if params[:time_punch][:name].empty? || params[:time_punch][:buddy].empty? then
			flash[:danger] = "You must fill both fields. If you are staff, select \"Staff\" as your buddy"
			redirect_to root_path
			return
		end	

		#error handler
		if params[:time_punch][:guest_name].empty? && params[:time_punch][:name] == "Guest" then
			flash[:danger] = "You must enter a Guest's name"
			redirect_to root_path
			return
		end
		
		#overwrite Guest name 
		if params[:time_punch][:name] == "Guest" && !params[:time_punch][:guest_name].empty? then
			params[:time_punch][:name] = params[:time_punch][:guest_name]
		end	
		
		#error handler
		if params[:time_punch][:bud].empty? && params[:time_punch][:buddy] == "Guest" then
			flash[:danger] = "You must enter a Guest's name (buddy)"
			redirect_to root_path
			return
		end
		
		#overwrite Guest buddy name
		if params[:time_punch][:buddy] == "Guest" && !params[:time_punch][:bud].empty? then
			params[:time_punch][:buddy] = params[:time_punch][:bud]
		end
		
		#error handler
		if params[:time_punch][:name] == params[:time_punch][:buddy] then
			flash[:danger] = "You need a buddy that is not yourself"
			redirect_to root_path
			return
		end	

		
		#when you login, first check if there exists a CheckIn with the same name.
		#if there is, then create a TimePunch (log out the user). If not, create a CheckIn		
		CheckIn.all.each do |check_in| 
			
			#this code block handles "logging out"
			if check_in.name == params[:time_punch][:name] then 
				@time_punch = TimePunch.new(name: params[:time_punch][:name])
				if @time_punch.save
					@time_punch.do_check_in check_in
					check_in.delete
					@time_punch.do_check_out
					if	@time_punch.save
						flash[:success] = "Successfully logged out"
						redirect_to root_path
					end
				end
				#return to prevent the rest of the code from creating a CheckIn instance
				return
			end
		end
		
		#store whether the user is a guest or not upon checkin. this is useful when downloading 
		#data under SelectionsController for all Guests
		if params[:time_punch][:guest_name].empty? then
			@time_punch = CheckIn.new(name: params[:time_punch][:name], buddy: params[:time_punch][:buddy], guest: false )
		else 
			@time_punch = CheckIn.new(name: params[:time_punch][:guest_name], buddy: params[:time_punch][:buddy], guest: true )
		
		end	
		#this code block handles Checking In	
		if @time_punch.save
			@time_punch.do_check_in
			flash[:success] = "Successfully logged in"
			redirect_to root_path
		end
  end

   private

    # Before filters

    
    # Confirms an fabrication user.
    def microfab_user
      redirect_to(login_path) unless current_user.admin? || current_user.microfab?
      
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
