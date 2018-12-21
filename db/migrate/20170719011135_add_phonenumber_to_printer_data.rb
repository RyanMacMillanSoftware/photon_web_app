class AddPhonenumberToPrinterData < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_data, :phonenumber, :string
  end
end
