class AddNameToPrinterStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_statuses, :name, :string
  end
end
