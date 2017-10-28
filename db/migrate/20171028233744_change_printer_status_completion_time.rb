class ChangePrinterStatusCompletionTime < ActiveRecord::Migration[5.0]
  def change
  	change_column :printer_statuses, :completion_time, :datetime
  end
end
