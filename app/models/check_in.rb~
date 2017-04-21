class CheckIn < ApplicationRecord

	validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: true }
   validate :student_needs_buddy

  #Check in and update attributes   
  def do_check_in
  	update_columns(time: DateTime.current(), 
  							seconds_since_midnight: DateTime.now.seconds_since_midnight())
  end
  
  private
		def student_needs_buddy
			user = User.find_by(name: name)
			return if user.name == 'Staff'

  			if user.name == "Student" && buddy.empty?
    			errors.add(:to_time, "students need a buddy") 
  			end 
		end
  
end
