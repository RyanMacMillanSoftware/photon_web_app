class TimePunchesController < ApplicationController
	
	before_action :logged_in_user
   
  def new
  	@time_punch = TimePunch.new
  end
  
	def create
		

		if params[:time_punch][:guest_name].empty? && params[:time_punch][:name] == "Guest" then
			flash[:danger] = "You must enter a Guest's name"
			redirect_to root_path
			return
		end
		
		if params[:time_punch][:name] == "Guest" && !params[:time_punch][:guest_name].empty? then
			params[:time_punch][:name] = params[:time_punch][:guest_name]
		end	
		
		if params[:time_punch][:bud].empty? && params[:time_punch][:buddy] == "Guest" then
			flash[:danger] = "You must enter a Guest's name (buddy)"
			redirect_to root_path
			return
		end
		
		
		if params[:time_punch][:buddy] == "Guest" && !params[:time_punch][:bud].empty? then
			params[:time_punch][:buddy] = params[:time_punch][:bud]
		end
	
		if params[:time_punch][:name] == params[:time_punch][:buddy] then
			flash[:danger] = "You need a buddy that is not yourself"
			redirect_to root_path
			return
		end	
				
		CheckIn.all.each do |check_in| 
			
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
				return
			end
		end
		
		if params[:time_punch][:guest_name].empty? then
			@time_punch = CheckIn.new(name: params[:time_punch][:name], buddy: params[:time_punch][:buddy], guest: false )
		else 
			@time_punch = CheckIn.new(name: params[:time_punch][:guest_name], buddy: params[:time_punch][:buddy], guest: true )
		
		end		
		if @time_punch.save
			@time_punch.do_check_in
			flash[:success] = "Successfully logged in"
			redirect_to root_path
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
