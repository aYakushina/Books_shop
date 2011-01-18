ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase


  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
		def check_routes path, controller, action 
			assert_routing path, { :controller => controller, :action => action} 
		end

		def check_routes_with_method path, method, controller, action 
			assert_routing({ :path => path, :method => method },  { :controller => controller, :action => action})
		end

		def check_routes_with_id path, controller, action, id 
			assert_routing path, { :controller => controller, :action => action,:id => id.to_s }
		end

		def check_routes_with_id_and_method path, method, controller, action,  id 
			assert_routing({ :path => path, :method => method },  { :controller => controller, :action => action, :id => id.to_s})
		end

		def need_authenticate 
			assert_redirected_to "/users/sign_in"
			assert_equal 'Вы должны авторизоваться', flash[:alert],"некорректное flash[:alert]"
		end

		def access_denied (msg="")
			assert_redirected_to root_url
			assert_equal 'Доступ запрещен!', flash[:alert], "некорректное flash[:alert]"
		end
end


