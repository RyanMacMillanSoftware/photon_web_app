class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.string :name
      t.datetime :time
      t.integer :seconds_since_midnight

      t.timestamps
    end
  end
end
