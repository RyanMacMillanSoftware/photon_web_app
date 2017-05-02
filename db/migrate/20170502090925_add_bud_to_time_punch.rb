class AddBudToTimePunch < ActiveRecord::Migration[5.0]
  def change
    add_column :time_punches, :bud, :string
  end
end
