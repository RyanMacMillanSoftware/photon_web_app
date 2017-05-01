class AddGuestToCheckIn < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :guest, :boolean
  end
end
