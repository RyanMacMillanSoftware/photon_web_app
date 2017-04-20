class AddBuddyToCheckIn < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :buddy, :string
  end
end
