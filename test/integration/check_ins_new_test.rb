require 'test_helper'

class CheckInsNewTest < ActionDispatch::IntegrationTest
  	
	def setup
    @admin_no_access       = users(:michael)
    @non_admin_no_access = users(:archer)
    @non_admin_with_access       = users(:stan)
    @admin_with_access = users(:stanny)
    @check_in = check_ins(:one)
  end  
  
  
  test "punch in, punch out" do
  	log_in_as(@non_admin_with_access)
    get root_path 
    assert_difference 'CheckIn.count', 1 do
     post root_path, params: { time_punch: { name:  "Frank", buddy: "Frank2", guest_name: "", bud: "" } }
    end
    assert_not flash.empty?
	 assert_redirected_to root_path
	 follow_redirect!
    assert_difference 'CheckIn.count', -1 do
     post root_path, params: { time_punch: { name:  "Frank", buddy: "Frank2", guest_name: "", bud: "" } }
    end
    assert_not flash.empty?
	 assert_redirected_to root_path
	end
   
  #  test "expire after midnight" do
  #	log_in_as(@non_admin_with_access)
  #  get root_path 
  #  CheckIn.delete_all
  #  assert_difference 'CheckIn.count', 1 do
  #   post root_path, params: { time_punch: { name:  "Frank", buddy: "Frank2", guest_name: "", bud: "" } }
  #  end
  # assert_not flash.empty?
	# assert_redirected_to root_path
	# follow_redirect!
#    
	#travel_to Time.now.change(hour: 11, min: 59, sec: 59)
	#travel_to Time.now.change(day: Time.now.day +1, hour: 0, min: 0, sec: 1) 
	 # assert_equal 0, CheckIn.count
	

	end
    
    
end
