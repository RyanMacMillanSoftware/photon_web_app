class StaticPagesController < ApplicationController


	before_action :logged_in_user
  

  def home
  end

  def help
  end
  
  def about
  end
  
  private
 
     # Before filters
 
     # Confirms a logged-in user.
     def logged_in_user
       unless logged_in?
       	store_location
         flash[:danger] = "Please log in."
         redirect_to login_url
       end
     end
end
