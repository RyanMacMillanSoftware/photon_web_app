require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
 def setup
    @admin       = users(:michael)
    @non_admin = users(:archer)
  end
  
   test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should redirect show when not logged in" do
    get user_path(@admin)
    assert_redirected_to login_url
  end
  
  test "admin should get new" do
  	log_in_as(@admin)
    get signup_path
    assert_response :success
  end
  
  test "sound redirect new when not admin" do
  	log_in_as(@non_admin)
  	get signup_path
  	assert_redirected_to root_url
  end
  
  
	test "should redirect edit when not logged in" do
    get edit_user_path(@admin)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@admin), params: { user: { name: @admin.name,
                                              email: @admin.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@non_admin)
    get edit_user_path(@admin)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@non_admin)
    patch user_path(@admin), params: { user: { name: @admin.name,
                                              email: @admin.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should allow the @microfab attribute to editted by admin" do
    log_in_as(@admin)
    patch user_path(@non_admin), params: {
                                    user: { password:              'password',
                                            password_confirmation: 'password',
                                            admin: true, microfab: "1" } }
    assert_not @non_admin.microfab?
  end
  
  test "should not allow the @microfab attribute to be edited via the web" do
    log_in_as(@non_admin)
    assert_not @non_admin.admin?
    patch user_path(@non_admin), params: {
                                    user: { password:              'password',
                                            password_confirmation: 'password',
                                            admin: true, microfab: "1" } }
    assert_not @non_admin.microfab?
  end
  
  test "should not allow the @admin attribute to be edited via the web" do
    log_in_as(@non_admin)
    assert_not @non_admin.admin?
    patch user_path(@non_admin), params: {
                                    user: { password:              'password',
                                            password_confirmation: 'password',
                                            admin: true, microfab: "0" } }
    assert_not @non_admin.admin?
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@admin)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-@admin" do
    log_in_as(@non_admin)
    assert_no_difference 'User.count' do
      delete user_path(@admin)
    end
    assert_redirected_to root_url
  end
  
  
end
