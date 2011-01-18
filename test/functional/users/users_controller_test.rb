require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
   
  end
	
	#тестирование routes
	test "should route to new sessions" do 
		check_routes '/users/sign_in', "devise/sessions", "new" 
	end
		
	test "should route to create sessions" do 
		check_routes_with_method '/users/sign_in', :post, "devise/sessions", "create" 
	end

	test "should route to destroy sessions" do 
		check_routes '/users/sign_out', "devise/sessions", "destroy" 
	end

	test "should route to create password" do 
		check_routes_with_method '/users/password', :post, "devise/passwords", "create" 
	end
	
	test "should route to new password" do 
		check_routes '/users/password/new', "devise/passwords", "new" 
	end

	test "should route to edit password" do 
		check_routes '/users/password/edit', "devise/passwords", "edit" 
	end

	test "should route to update password" do 
		check_routes_with_method '/users/password', :put, "devise/passwords", "update" 
	end

	test "should route to create registration" do 
		check_routes_with_method '/users', :post, "devise/registrations", "create" 
	end

	test "should route to new registrations" do 
		check_routes '/users/register', "devise/registrations", "new" 
	end

	test "should route to edit registrations" do 
		check_routes '/users/edit', "devise/registrations", "edit" 
	end

	test "should route to update registration" do 
		check_routes_with_method '/users', :put, "devise/registrations", "update" 
	end

	test "should route to destroy registration" do 
		check_routes_with_method '/users', :delete, "devise/registrations", "destroy" 
	end

end
