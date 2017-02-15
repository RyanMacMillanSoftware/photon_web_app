require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
    @not_activated = users(:malory)
  end

 test "index as admin including pagination and delete and edit links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    
    assert_select 'a[href=?]', signup_path, text: 'Add User'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
    	if user.activated?
      	assert_select 'a[href=?]', user_path(user), text: user.name
		
     		if user.admin? && user != @admin
        		assert_select 'a[href=?]', user_path(user), text: 'edit', count: 0
         	assert_select 'a[href=?]', user_path(user), text: 'delete', count: 0
         end
			if user == @admin         
         	assert_select 'a[href=?]', edit_user_path(user), text: 'edit'
        end
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
	assert_select 'a', text: 'edit', count: 1
	assert_select 'a', text: 'Add User', count: 0
  end
  
  test "index without non authenticated" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'Malory Archer', count: 0
   end
  
end