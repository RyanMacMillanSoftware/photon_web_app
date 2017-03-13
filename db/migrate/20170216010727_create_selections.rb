class CreateSelections < ActiveRecord::Migration[5.0]
  def change
    create_table :selections do |t|
      t.datetime :from_time
      t.datetime :to_time

      t.timestamps
    end
  end
end
