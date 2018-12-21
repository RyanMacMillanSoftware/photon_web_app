class AddQuestNameToTimePunches < ActiveRecord::Migration[5.0]
  def change
    add_column :time_punches, :guest_name, :string
    add_column :time_punches, :buddy, :string
  end
end
