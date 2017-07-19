class PrinterDatum < ApplicationRecord

validates :name,  presence: true, length: { maximum: 50 }
validates :project,  presence: true, length: { maximum: 50 }
validates :printer,  presence: true, length: { maximum: 50 }
validates :phonenumber, :numericality => {:only_integer => true}
validates :from_time, presence: true
validates :to_time, presence: true
validate :to_must_be_before_from_time



private
	#handle error when time's are not in proper order
	def to_must_be_before_from_time
      return if to_time.blank? || from_time.blank?

  		if to_time < from_time
    		errors.add(:to_time, "cannot be before the from time") 
  		end 
	end 

end

