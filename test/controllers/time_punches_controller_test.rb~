require 'test_helper'

class TimePunchControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @no_access = users(:archer)
  end
  
   test "should redirect microfab when not logged in" do
    get microfab_path
    assert_redirected_to login_url
  end
  
  test "should redirect microfab when no permissions" do
  	 log_in_as(@no_access) 
    get microfab_path
    assert_redirected_to root_url
  end
  
  
end
