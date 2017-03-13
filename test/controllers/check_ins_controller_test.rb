require 'test_helper'

class CheckInsControllerTest < ActionDispatch::IntegrationTest
	
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
    @check_in = check_ins(:one)
  end  
  
  
  test "should redirect check in edit when not logged in and when not admin" do
    get edit_check_in_path(@check_in)
    assert_redirected_to root_url
    log_in_as(@non_admin_with_access)
    get edit_check_in_path(@check_in)
    assert_redirected_to root_url
  end
  	
	test "should get check in edit when admin" do
    log_in_as(@admin_with_access)
    get edit_check_in_path(@check_in)
    assert_template 'check_ins/edit'
  end
  
  test "should not get check in edit when admin without access" do
    log_in_as(@admin_no_access)
    get edit_check_in_path(@check_in)
    assert_redirected_to root_url
  end
  	  	
  	
end
