class AddTemporaryPasswordToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :temporary_password, :string
    add_column :users, :temporary_active, :boolean
  end
end
