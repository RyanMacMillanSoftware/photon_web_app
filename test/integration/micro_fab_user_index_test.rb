require 'test_helper'

class MicroFabUserIndexTest < ActionDispatch::IntegrationTest
	
	def setup
    @reuben       = micro_fab_users(:rc)
    @james = micro_fab_users(:jp)
    @admin       = users(:michael)
    @non_admin       = users(:stan)
  end
  
  test "test layout" do
  	log_in_as(@admin)
    get micro_fab_users_path 
    assert_template 'micro_fab_users/index'
  	
  	assert_select 'a', text: 'delete'
	assert_select 'a', text: 'edit'
	
	end
	
	test "test delete as admin" do
	log_in_as(@admin)
	get micro_fab_users_path
  	assert_difference 'MicroFabUser.count', -1 do
     delete micro_fab_user_path(@james)
    end
    
	assert_not flash.empty?
	assert_redirected_to micro_fab_users_path
	end
	
	test "test delete as non-admin" do
	log_in_as(@non_admin)
	get micro_fab_users_path
  	assert_difference 'MicroFabUser.count', 0 do
     delete micro_fab_user_path(@james)
    end
    
	end
	
  
end