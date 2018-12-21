class RemovePhoneFromPrinterData < ActiveRecord::Migration[5.0]
  def change
    remove_column :printer_data, :phone, :integer
  end
end
