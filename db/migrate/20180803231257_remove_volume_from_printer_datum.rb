class RemoveVolumeFromPrinterDatum < ActiveRecord::Migration[5.0]
  def change
    remove_column :printer_data, :volume, :integer
  end
end
