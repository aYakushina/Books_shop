class AdminController < ApplicationController
before_filter :authenticate_user! 
before_filter :admin_authenticate, :only => [:list_of_users] 
		 
	def list_of_users
    @users = User.all
  end

	def quit
		delete_cart
		redirect_to destroy_user_session_path
	end 

end
