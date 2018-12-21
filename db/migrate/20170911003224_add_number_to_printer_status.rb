class AddNumberToPrinterStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_statuses, :number, :string
  end
end
