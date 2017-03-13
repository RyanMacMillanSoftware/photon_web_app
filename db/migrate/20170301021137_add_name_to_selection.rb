class AddNameToSelection < ActiveRecord::Migration[5.0]
  def change
    add_column :selections, :name, :string
  end
end
