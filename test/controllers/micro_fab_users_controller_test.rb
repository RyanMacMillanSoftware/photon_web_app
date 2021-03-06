require 'test_helper'

class MicroFabUsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @reuben       = micro_fab_users(:rc)
    @james = micro_fab_users(:jp)
    @admin       = users(:michael)
    @non_admin = users(:archer)
  end
  
	test "should redirect new when logged in as non admin" do
    log_in_as(@non_admin)
    get new_micro_fab_user_path
    assert flash.empty?
    assert_redirected_to login_path
  end  

	test "should redirect index when logged in as non admin" do
    log_in_as(@non_admin)
    get micro_fab_users_path
    assert flash.empty?
    assert_redirected_to login_path
  end  
  
  test "should redirect index when not logged in" do
    get micro_fab_users_path
    assert flash.empty?
    assert_redirected_to login_path
  end
  
	test "should redirect edit when not logged in" do
    get edit_micro_fab_user_path(@james)
    assert flash.empty?
    assert_redirected_to login_path
  end

	test "should redirect delete when not logged in" do
     assert_no_difference 'MicroFabUser.count' do
       delete micro_fab_user_path(@james)
     end
     assert_redirected_to login_path
  end

end
