class AddOtherBuddyNameToTimePunch < ActiveRecord::Migration[5.0]
  def change
    add_column :time_punches, :other_name, :string
  end
end
