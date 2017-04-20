class RemoveBuddyFromCheckIn < ActiveRecord::Migration[5.0]
  def change
    remove_column :check_ins, :buddy, :String
  end
end
