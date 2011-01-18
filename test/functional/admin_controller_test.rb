require 'test_helper'

class AdminControllerTest < ActionController::TestCase
	include Devise::TestHelpers 

	setup do
		sign_in users(:admin)
  end

  #тестирование action

	test "should get list of users" do
    get :list_of_users
    assert_response :success
		[users(:admin), users(:user)].each do |user|
			assert assigns(:users).detect(user)
		end
  end
 
	test "should quit" do
    get :quit
		assert session[:cart] == nil
    assert_redirected_to destroy_user_session_path
  end

	# тестирование прав доступа и аутентификации
	
	test "should not get list of users" do
		sign_out users(:admin)
		get :list_of_users
		need_authenticate
    sign_in users(:user)				
		get :list_of_users
		access_denied
  end

	test "should not quit" do
		sign_out users(:admin)
	 	get :quit
		need_authenticate
  end

	#тестирование routes
	test "should route to list of user" do 
		check_routes '/admin/list_of_users', "admin", "list_of_users"  
	end

end
