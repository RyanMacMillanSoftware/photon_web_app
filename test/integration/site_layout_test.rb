require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	def setup
    @admin_with_microfab_access = users(:stanny)
  end

  
  
  test "layout links logged in microfab access" do
  	log_in_as(@admin_with_microfab_access)
    get root_path
    assert_template 'time_punches/new'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", logout_path
	 get contact_path
    assert_select "title", full_title("Contact")
  end
  
   test "layout links" do
    get root_path
	follow_redirect!
    assert_template 'sessions/new'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
  end
 
end