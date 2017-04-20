class RemoveBuddyFromTimePunch < ActiveRecord::Migration[5.0]
  def change
    remove_column :time_punches, :buddy, :String
  end
end
