require 'test_helper'

class CheckInsNewTest < ActionDispatch::IntegrationTest
  	
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
    @check_in = check_ins(:one)
  end  
  
  
  test "punch in, punch out" do
  	log_in_as(@non_admin_with_access)
    get microfab_path 
    assert_difference 'CheckIn.count', 1 do
     post microfab_path, params: { time_punch: { name:  "Frank", buddy: "Frank2", guest_name: "", bud: "" } }
    end
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	 follow_redirect!
    assert_difference 'CheckIn.count', -1 do
     post microfab_path, params: { time_punch: { name:  "Frank", buddy: "Frank2", guest_name: "", bud: "" } }
    end
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	end
    
    
end
