class AddImageToPrinterStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_statuses, :image, :string
  end
end
