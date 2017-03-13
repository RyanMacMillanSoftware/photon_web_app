class AddMicrofabToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :microfab, :boolean
  end
end
