class AddGuestNameToTimePunch < ActiveRecord::Migration[5.0]
  def change
    add_column :time_punches, :guest_name, :string
  end
end
