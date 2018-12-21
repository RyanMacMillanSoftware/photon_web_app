class AddPhoneToPrinterData < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_data, :phone, :integer
  end
end
