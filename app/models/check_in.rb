class CheckIn < ApplicationRecord

	validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: true }

  #Check in and update attributes   
  def do_check_in
  	update_columns(time: DateTime.current(), 
  							seconds_since_midnight: DateTime.now.seconds_since_midnight())
  end
  
end
