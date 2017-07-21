class AddToTimeToPrinterDatum < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_data, :to_time, :datetime
  end
end
