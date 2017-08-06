class CreatePrinterData < ActiveRecord::Migration[5.0]
  def change
    create_table :printer_data do |t|
      t.string :name
      t.string :project
      t.string :printer
      t.datetime :from_time
      t.datetime :to_time
      t.integer :volume
      t.string :notes

      t.timestamps
    end
  end
end
