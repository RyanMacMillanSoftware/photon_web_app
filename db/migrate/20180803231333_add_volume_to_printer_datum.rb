class AddVolumeToPrinterDatum < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_data, :volume, :string
  end
end
