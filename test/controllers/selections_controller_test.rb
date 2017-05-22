require 'test_helper'

class SelectionsControllerTest < ActionDispatch::IntegrationTest
  
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
  end
  
   test "should redirect selections when not logged in" do
    get new_selection_path
    assert_redirected_to login_url
  end
  
  
  test "should redirect selections when non-admin with microfab access" do
  	 log_in_as(@non_admin_with_access) 
    get new_selection_path
    assert_redirected_to root_path
  end
    
	test "should access selections when admin with microfab access" do
	 log_in_as(@admin_with_access) 
    get new_selection_path
    
	 assert_template 'selections/new'
  end  
  
end
