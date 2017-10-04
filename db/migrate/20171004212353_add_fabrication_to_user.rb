class AddFabricationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fabrication, :boolean
  end
end
