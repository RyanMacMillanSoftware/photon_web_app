class AddNumberToFabricationUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fabrication_users, :number, :string
  end
end
