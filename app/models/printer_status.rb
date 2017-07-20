class PrinterStatus < ApplicationRecord
validates :printer,  presence: true, length: { maximum: 50 }
  
end
