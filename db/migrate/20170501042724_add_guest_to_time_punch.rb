class AddGuestToTimePunch < ActiveRecord::Migration[5.0]
  def change
    add_column :time_punches, :guest, :boolean
  end
end
