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
     post microfab_path, params: { time_punch: { name:  @admin_with_access.name } }
    end
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	 follow_redirect!
    assert_difference 'CheckIn.count', -1 do
     post microfab_path, params: { time_punch: { name:  @admin_with_access.name } }
    end
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	end
	
	test "deleting check ins as admin" do
  	 log_in_as(@admin_with_access)
    get microfab_path
    assert_difference 'CheckIn.count', -1 do
      delete check_in_path(@check_in), params: {id: @check_in.id}
    end 
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	end
	
	test "deleting check ins as non-admin" do
  	 log_in_as(@non_admin_with_access)
    get microfab_path
    assert_difference 'CheckIn.count', 0 do
      delete check_in_path(@check_in), params: {id: @check_in.id}
    end 
	end
    
    
end
