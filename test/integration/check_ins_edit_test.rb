require 'test_helper'

class CheckInsEditTest < ActionDispatch::IntegrationTest
  
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
    @check_in = check_ins(:one)
  end   
  
  
  test "edit check in with valid inputs" do
  	log_in_as(@admin_with_access)
    get microfab_path 
    post microfab_path, params: { time_punch: { name:  @admin_with_access.name } }
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	 check_in = CheckIn.find_by(name: @admin_with_access.name)
	 get edit_check_in_path(check_in)
	 patch check_in_path(check_in), params: { check_in: { name:  'fake name' , 'time(4i)': 00, 'time(5i)': 00} }
	 assert_not flash.empty?
	 
	 assert_redirected_to microfab_path
	 follow_redirect!
	 check_in = CheckIn.find_by(name: 'fake name')
	 assert check_in.name == "fake name"
      	
	end
	
	test "edit check in with ininvalid inputs" do
  	log_in_as(@admin_with_access)
    get microfab_path 
    post microfab_path, params: { time_punch: { name:  @admin_with_access.name } }
    post microfab_path, params: { time_punch: { name:  @non_admin_with_access.name } }
    assert_not flash.empty?
	 assert_redirected_to microfab_path
	 check_in = CheckIn.find_by(name: @admin_with_access.name)
	 get edit_check_in_path(check_in)
	 patch check_in_path(check_in), params: { check_in: { name:  @non_admin_with_access.name , 'time(4i)': 12, 'time(5i)': 00} }
	 
	 
	 assert_template 'check_ins/edit'
    
	 assert_not flash.empty?  	
    assert check_in.name == @admin_with_access.name
	end
	  
	  
  
end
