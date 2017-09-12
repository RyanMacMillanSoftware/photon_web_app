class PrinterStatusesController < ApplicationController
  
  before_action :admin_user, only: [:destroy, :new, :create]
  

  #delete the user
  def destroy
    PrinterStatus.find(params[:id]).destroy
    flash[:success] = "Printer deleted"
    redirect_to printer_statuses_path
  end  
  
 def show
 end
  
  def new
  	@new_printer= PrinterStatus.new
  end
  
	def create
    @new_printer = PrinterStatus.new(ps_params)
    @new_printer.available = true;

     if @new_printer.save
    	flash[:success] = "Printer created"
      redirect_to printer_statuses_path
    else
      render 'new'
    end
  end
 


   private

    def ps_params
      params.require(:printer_status).permit(:printer)
    end


   
    
    # Confirms an admin user.
    def admin_user
    	if current_user.nil?
      	redirect_to(login_path)
      else
      	redirect_to(login_path) unless current_user.admin?
      end
    end
end
