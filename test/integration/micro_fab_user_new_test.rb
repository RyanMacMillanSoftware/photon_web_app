require 'test_helper'

class MicroFabUserNewTest < ActionDispatch::IntegrationTest
	
	def setup
    @reuben       = micro_fab_users(:rc)
    @james = micro_fab_users(:jp)
    @admin       = users(:michael)
  end
  
  test "create new user" do
  	log_in_as(@admin)
    get new_micro_fab_user_path 
    assert_difference 'MicroFabUser.count', 1 do
     post micro_fab_users_path, params: { micro_fab_user: {name: "Ryan", email: "r@r.com"} }
    end
    assert_not flash.empty?
	 assert_redirected_to micro_fab_users_path
	end
  
end