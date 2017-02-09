class TimePunchesController < ApplicationController
	
	before_action :logged_in_user
  before_action :admin_user,     only: [:index]
   
  def destroy
  	TimePunch.delete_all
	flash[:info] = "Saved data deleted"
  end  
  
  def index
  
   @time_punches = TimePunch.order(:check_in)
    respond_to do |format|
      format.html
      format.csv { send_data @time_punches.to_csv }
 		format.xls 
 	end
    
	flash[:info] = "Check your browser downloads"
  end


  def new
  	@time_punch = TimePunch.new
  end
  
	def create
		CheckIn.all.each do |check_in| 
			if check_in.name == params[:time_punch][:name] then 
				
				@time_punch = TimePunch.new(name: params[:time_punch][:name])
				if @time_punch.save
					@time_punch.do_check_in check_in
					check_in.delete
					@time_punch.do_check_out				
					@time_punch.save
					flash[:success] = "Successfully punched out"
					redirect_to microfab_path
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
