class AddFromTimeToPrinterDatum < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_data, :from_time, :datetime
  end
end
