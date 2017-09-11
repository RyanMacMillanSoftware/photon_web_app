require 'test_helper'

class PrinterStatusesIndexTest < ActionDispatch::IntegrationTest

	def setup
	@admin = users(:michael)
	@non_admin = users(:archer)
	@printer_one = printer_statuses(:one)
    @printer_two = printer_statuses(:two)
  	end

  	#test "cannot delete a printer status instance as non admin" do
  	#	log_in_as(@non_admin)
  	#	assert_difference 'PrinterStatus.count', 0 do
    #		delete printer_status_path(@printer_one)
    #	end
  	#end


end
    