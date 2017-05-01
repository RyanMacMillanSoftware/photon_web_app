class TimePunch < ApplicationRecord

validates :name,  presence: true, length: { maximum: 50 }

  #Check in and update attributes   
  def do_check_in(check_in)
  	update_columns(name: check_in.name, check_in: check_in.time, check_in_seconds: check_in.seconds_since_midnight, guest: check_in.guest)
					
  end
  
  
  #Check out and update attributes   
  def do_check_out
  	update_columns(check_out: DateTime.current(), check_out_seconds: DateTime.now.seconds_since_midnight())
	elapsed = (((check_out - check_in).to_f)/60).ceil
	update_attribute(:seconds_elapsed, elapsed)  	
  end

	

end
