class CreatePrinterStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :printer_statuses do |t|
      t.string :printer
      t.boolean :available
      t.time :completion_time

      t.timestamps
    end
  end
end
