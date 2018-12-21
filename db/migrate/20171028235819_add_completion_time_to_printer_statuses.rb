class AddCompletionTimeToPrinterStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :printer_statuses, :completion_time, :datetime
  end
end
