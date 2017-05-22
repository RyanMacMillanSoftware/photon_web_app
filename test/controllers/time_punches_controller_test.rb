require 'test_helper'

class TimePunchControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @no_access = users(:archer)
  end
  
   test "should redirect microfab when not logged in" do
    get root_path
    assert_redirected_to login_url
  end
  
  
  
end
