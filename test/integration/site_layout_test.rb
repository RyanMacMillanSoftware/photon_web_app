require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	def setup
    @user = users(:michael)
  end

  test "layout links logged in" do
  	log_in_as(@user)
    get root_path
    assert_template 'sessions#new'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
	 get contact_path
    assert_select "title", full_title("Contact")
  end
  
   test "layout links" do
    get root_path
	follow_redirect!
    assert_template 'sessions/new'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end
 
end