require 'test_helper'

class PrinterDataControllerTest < ActionDispatch::IntegrationTest

 def setup
    @admin       = users(:michael)
    @non_admin = users(:archer)
  end

  test "redirect new data when not logged in" do
  	get new_printer_datum_path
  	assert_redirected_to login_url
  end
end
