class TimePunch < ApplicationRecord

validates :name,  presence: true, length: { maximum: 50 }

  #Check in and update attributes   
  def do_check_in(check_in)
  	update_columns(name: check_in.name, check_in: check_in.time, check_in_seconds: check_in.seconds_since_midnight)
					
  end
  
  
  #Check out and update attributes   
  def do_check_out(seconds_since_midnight)
  	update_columns(check_out: DateTime.current(), check_out_seconds: seconds_since_midnight)
	elapsed = self.check_out_seconds-self.check_in_seconds
	update_attribute(:seconds_elapsed, (self.check_out_seconds-self.check_in_seconds))  	
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << 'Name' << 'Check In Time' << 'Check Out Time' << 'Seconds Elapsed'
      all.each do |timepunch|
        csv << timepunch.attributes.values_at("name", "check_in", "check_out", "seconds_elapsed")

      end
    end
  end
	

end
