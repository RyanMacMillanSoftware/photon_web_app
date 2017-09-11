require 'test_helper'

#weak tests

class PrinterDatumNewTest < ActionDispatch::IntegrationTest
  	
	def setup
    @non_admin = users(:stan)
    @admin = users(:stanny)
    @printer = printer_statuses(:one)
  end  

  test "create a valid printer datum" do
    log_in_as(@admin)
    get new_printer_datum_path
    assert_difference 'PrinterDatum.count', 1 do
    post new_printer_datum_path, params: { printer_datum: { name: "Frank", phonenumber: 02144433321,
                                          project: "TPA", printer: @printer.printer, hour: DateTime.now.hour, minute: DateTime.now.minute, 
                                          meridian: "PM", volume: 20, notes: "Hello" } }
    end
  end
  
end
