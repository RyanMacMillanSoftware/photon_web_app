require 'test_helper'

class PrinterSelectionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin       = users(:michael)
    @non_admin = users(:archer)
  end

  test "should redirect printer selections when not logged in" do
    get new_printer_selection_path
    assert_redirected_to login_url
  end
  
  
  test "should redirect printer selections when non-admin" do
  	 log_in_as(@non_admin) 
    get new_selection_path
    assert_redirected_to root_path
  end

end
