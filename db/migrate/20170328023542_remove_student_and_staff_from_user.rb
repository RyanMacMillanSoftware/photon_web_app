class RemoveStudentAndStaffFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :student, :boolean
    remove_column :users, :staff, :boolean
  end
end
