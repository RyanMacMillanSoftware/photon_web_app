require 'test_helper'

#weak tests

class SelectionsNewTest < ActionDispatch::IntegrationTest
  	
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
    @check_in = check_ins(:one)
  end 
  
   test "invalid selection range" do
     log_in_as(@admin_with_access) 
    get new_selection_path
    assert_template 'selections/new'
  	 post selections_path, params: { selection: {  'from_time(1i)':  2018, 'from_time(2i)': 1, 'from_time(3i)': 1, 
  	 											'to_time(1i)': 2017, 'to_time(2i)': 1, 'to_time(3i)': 10, name: '' } }
    
    assert_template 'selections/new'
  end
    
	test "valid input" do
	 log_in_as(@admin_with_access) 
    get new_selection_path
    post selections_path, params: { selection: {  'from_time(1i)':  2017, 'from_time(2i)': 1, 'from_time(3i)': 1,
    											 'to_time(1i)': 2017, 'to_time(2i)': 1, 'to_time(3i)': 10, name: '' } }
   
    assert_select 'a', text: 'Submit', count: 0
    assert Selection.count == 0
    
  end  
  
end
