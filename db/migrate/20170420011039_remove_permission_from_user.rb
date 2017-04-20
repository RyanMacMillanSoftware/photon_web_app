class RemovePermissionFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :permission, :string
  end
end
