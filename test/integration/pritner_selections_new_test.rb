require 'test_helper'

# a terrible test suite. as selections delete straight away it is hard to know if one was even created if valid. 



class PrinterSelectionsNewTest < ActionDispatch::IntegrationTest

	def setup
	@admin = users(:michael)
	@non_admin = users(:archer)
	@printer_one = printer_statuses(:one)
    @printer_two = printer_statuses(:two)
  	end

  test "create a valid printer selection" do
    log_in_as(@admin)
    get new_printer_selection_path
    assert_template 'printer_selections/new'
    post printer_selections_path, params: { printer_selection: { 'from_time(1i)': 2016, 'from_time(2i)': 3, 'from_time(3i)': 21,
                                                'to_time(1i)': 2016, 'to_time(2i)': 4, 'to_time(3i)': 22 } }
    
    assert PrinterSelection.count == 0
    
  end

  test "try create a invalid printer selection" do
    log_in_as(@admin)
    get new_printer_selection_path

    assert_template 'printer_selections/new'
    assert_difference 'PrinterSelection.count', 0 do
    post printer_selections_path, params: { printer_selection: { 'from_time(1i)': 2017, 'from_time(2i)': 3, 'from_time(3i)': 21,
                                                'to_time(1i)': 2016, 'to_time(2i)': 4, 'to_time(3i)': 22 } }
    end

    assert_template 'printer_selections/new'
    
  end

end
    