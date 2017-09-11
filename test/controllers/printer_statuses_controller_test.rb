require 'test_helper'

class PrinterStatusesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @available       = printer_statuses(:one)
    @not_available = printer_statuses(:two)
    @admin       = users(:michael)
    @non_admin = users(:archer)
  end

  test "no redirect when not logged in" do 
  	get printer_statuses_path
  	assert_template 'printer_statuses/index'
  end

  test "no redirect when logged in" do 
  	get printer_statuses_path(@non_admin)
  	assert_template 'printer_statuses/index'
  end  

  test "should redirect new when not admin" do
  	get new_printer_status_path(@non_admin)
  	assert_redirected_to login_url
  end

  #test "shound not delete when not admin" do
  #	log_in_as(@non_admin)
  #  get printer_statuses_path 
  #  assert_difference 'CheckIn.count', 0 do
  #   delete printer_statuses_path(@one)
  #  end
  #end

end
