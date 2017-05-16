require 'test_helper'

class MicroFabUserEditTest < ActionDispatch::IntegrationTest
	
	def setup
    @reuben       = micro_fab_users(:rc)
    @james = micro_fab_users(:jp)
    @admin       = users(:michael)
    @non_admin       = users(:stan)
  end
  
  test "test layout" do
  	log_in_as(@admin)
    get edit_micro_fab_user_path(@reuben)
    assert_template 'micro_fab_users/edit'
  	
	
	end
	
	test "test edit name as admin" do
	log_in_as(@admin)
	get edit_micro_fab_user_path(@reuben)
	name = "Ryan"
	email = "r@r.com"
   patch micro_fab_user_path(@reuben), params: { micro_fab_user: { name:  name,
                                              email: email} }
   
   @reuben.reload
	assert_not flash.empty?
	assert_redirected_to micro_fab_users_path
	assert_equal @reuben.name, name
	assert_equal @reuben.email, email
	end
	
	test "test edit name as non-admin" do
	log_in_as(@non_admin)
	get edit_micro_fab_user_path(@reuben)
	name = "Ryan"
	email = "r@r.com"
   patch micro_fab_user_path(@reuben), params: { micro_fab_user: { name:  name,
                                              email: email} }
   
   @reuben.reload
	assert_not_equal @reuben.name, name
	assert_not_equal @reuben.email, email
	end
	
  
end