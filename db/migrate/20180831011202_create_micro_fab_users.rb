class CreateMicroFabUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :micro_fab_users do |t|
      t.string :name
      t.string :email
    end
  end
end
