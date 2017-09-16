class PrinterDatum < ApplicationRecord

validates :name,  presence: true, length: { maximum: 50 }
validates :project,  presence: true, length: { maximum: 50 }
#validates :printer,  presence: true, length: { maximum: 50 }
validates :phonenumber, :numericality => {:only_integer => true}
validates :to_time, presence: true
validates :volume, :numericality => {:only_integer => true}


end

