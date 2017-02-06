require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@base_title = "The Photon Factory"
		@user = users(:michael)
		
	end
		  
  test "should get home" do
  		log_in_as(@user)
    	get root_path
    	assert_response :success
    	assert_select "title", "#{@base_title}"
  end

  test "should get help" do
  log_in_as(@user)
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
	
  end

  test "should get about" do
	log_in_as(@user)    
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
	 
  end
  
  test "should get contact" do
	log_in_as(@user)    
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  
  end
end