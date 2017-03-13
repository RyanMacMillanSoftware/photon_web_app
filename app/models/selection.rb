class Selection < ApplicationRecord

validates :from_time, presence: true
validates :to_time, presence: true
validate :to_must_be_before_from_time



private

	def to_must_be_before_from_time
      return if to_time.blank? || from_time.blank?

  		if to_time < from_time
    		errors.add(:to_time, "cannot be before the from time") 
  		end 
	end 

end
