class PrinterStatus < ApplicationRecord
#attr_accessible :printer, :name, :image, :remote_image_url, :availabile, :completion_time, :name, :number
validates :printer,  presence: true, length: { maximum: 50 }
mount_uploader :image, ImageUploader
end
