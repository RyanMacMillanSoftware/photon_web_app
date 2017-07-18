class CreatePrinterData < ActiveRecord::Migration[5.0]
  def change
    create_table :printer_data do |t|
      t.string :name
      t.string :project
      t.string :printer
      t.time :from_time
      t.time :to_time
      t.integer :volume
      t.string :notes

      t.timestamps
    end
  end
end
