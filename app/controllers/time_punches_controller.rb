class TimePunchesController < ApplicationController
	
	before_action :logged_in_user
  before_action :admin_user,     only: [:index, :destroy]
   
   
  def edit
  	#undo
 	if CheckIn.first then
		latest_check_in = CheckIn.first 	
  		CheckIn.all.each do |check_in|
  			if check_in.seconds_since_midnight > latest_check_in.seconds_since_midnight then
  				latest_check_in = check_in
  			end
 	 	end
  		latest_check_in.delete
		flash[:info] = "Undone punch in"
  		redirect_to microfab_path
  	end
  end
  
  def destroy
  	TimePunch.delete_all
	flash[:info] = "Saved data deleted"
	redirect_to microfab_path
  end  
  
  def index
  
   @time_punches = TimePunch.order(:check_in)
    respond_to do |format|
      format.html
      format.csv { send_data @time_punches.to_csv }
 		format.xls 
 		flash[:info] = "Check your browser downloads"
		redirect_to microfab_path
 	end
  end


  def new
  	@time_punch = TimePunch.new
  end
  
	def create
		seconds_since_midnight = DateTime.now.seconds_since_midnight()
		CheckIn.all.each do |check_in| 
			
			if check_in.name == params[:time_punch][:name] then 
				if (0 > (seconds_since_midnight - check_in.seconds_since_midnight)) then
					check_in.delete
				
					flash[:failure] = "Punch failed. You must punch out on the same day you punch in."
					
					return
				end	
				@time_punch = TimePunch.new(name: params[:time_punch][:name])
				if @time_punch.save
					@time_punch.do_check_in check_in
					check_in.delete
					@time_punch.do_check_out(seconds_since_midnight)
					if	@time_punch.save
						flash[:success] = "Successfully punched out"
						redirect_to microfab_path
					end
				end
				return
			end
		end
		@time_punch = CheckIn.new(name: params[:time_punch][:name])
		if @time_punch.save
			@time_punch.do_check_in
			flash[:success] = "Successfully punched in"
			redirect_to microfab_path
		end
  end

   private

    # Before filters

    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(root_url)
      else
      	redirect_to(root_url) unless current_user.admin?
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
