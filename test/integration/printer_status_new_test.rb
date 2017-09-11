require 'test_helper'

class PrinterStatusesNewTest < ActionDispatch::IntegrationTest

	def setup
	@admin = users(:michael)
	@non_admin = users(:archer)
	@printer_one = printer_statuses(:one)
    @printer_two = printer_statuses(:two)
  	end

  test "create a valid printer status" do
    log_in_as(@admin)
    get new_printer_status_path
    assert_difference 'PrinterStatus.count', 1 do
    post printer_statuses_path, params: { printer_status: { printer: "Prtiner1" } }
    end
  end

  test "try create a invalid printer status" do
    log_in_as(@admin)
    get new_printer_status_path
    assert_difference 'PrinterStatus.count', 0 do
    post printer_statuses_path, params: { printer_status: { printer: "" } }
    end
  end

end
    