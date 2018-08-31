require 'test_helper'

#weak tests

class PrinterDatumNewTest < ActionDispatch::IntegrationTest
  	
	def setup
    @non_admin = users(:stan)
    @admin = users(:stanny)
    @f_user = fabrication_users(:jp)
    @printer = printer_statuses(:one)
  end  

  test "create a valid printer datum" do
    log_in_as(@admin)
    assert_difference 'PrinterDatum.count', 1 do
    post new_printer_datum_path(printer: @printer.id), params: { printer_datum: { name: @f_user.name, phonenumber: 02144433321,
                                          project: "TPA", printer: @printer.printer, 'to_time(4i)': DateTime.now.hour, 'to_time(5i)': DateTime.now.minute, 
                                          meridian: "PM", volume: 20, notes: "Hello" } }
    end
  end

  test "create a invalid printer datum" do
    log_in_as(@admin)
    assert_difference 'PrinterDatum.count', 0 do
    post new_printer_datum_path(printer: @printer.id), params: { printer_datum: { name: @f_user.name, phonenumber: -1,
                                          project: "", printer: @printer.printer, 'to_time(4i)': DateTime.now.hour, 'to_time(5i)': DateTime.now.minute, 
                                          meridian: "PM", volume: -1, notes: "" } }
    end
  end
  
end
