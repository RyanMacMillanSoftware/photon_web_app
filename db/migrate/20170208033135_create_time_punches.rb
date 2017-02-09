class CreateTimePunches < ActiveRecord::Migration[5.0]
  def change
    create_table :time_punches do |t|
      t.string :name
      t.datetime :check_in
      t.datetime :check_out
      t.integer :check_in_seconds
      t.integer :check_out_seconds
      t.integer :seconds_elapsed

      t.timestamps
    end
  end
end
