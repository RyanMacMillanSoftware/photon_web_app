class RemoveCompletionTimeFromPrinterStatuses < ActiveRecord::Migration[5.0]
  def change
    remove_column :printer_statuses, :completion_time, :time
  end
end
