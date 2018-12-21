require 'test_helper'

class PrinterStatusesIndexTest < ActionDispatch::IntegrationTest

	def setup
	@admin = users(:michael)
	@non_admin = users(:stan)
	@printer_one = printer_statuses(:one)
    @printer_two = printer_statuses(:two)
  	end

  	test "index appears as it should for a guest" do
      get printer_statuses_path
      assert_template 'printer_statuses/index'
     assert_select "a[href=?]", new_printer_status_path, count: 0
     assert_select "a[href=?]", new_printer_datum_path, count: 0
     assert_select "a[href=?]", new_printer_selection_path, count: 0
     assert_select "a[href=?]", login_path
     assert_select "a[href=?]", printer_statuses_path
    end

    test "index appears as it should for a non admin" do
      log_in_as(@non_admin)
      get printer_statuses_path
      assert_template 'printer_statuses/index'
     assert_select "a[href=?]", new_printer_status_path, count: 0
     assert_select "a[href=?]", new_printer_datum_path(printer: @printer_one.id)
     assert_select "a[href=?]", new_printer_selection_path, count: 0
    end

    test "index appears as it should for an admin" do
      log_in_as(@admin)
      get printer_statuses_path
      assert_template 'printer_statuses/index'
     assert_select "a[href=?]", new_printer_status_path
     assert_select "a[href=?]", new_printer_datum_path(printer: @printer_one.id)
     assert_select "a[href=?]", new_printer_selection_path
    end


end
    