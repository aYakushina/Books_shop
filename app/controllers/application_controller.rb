class ApplicationController < ActionController::Base
	include ApplicationHelper
  protect_from_forgery
	
private  
	
	def admin_authenticate
	  if current_user!= nil
			if !current_user.is_admin?
			flash[:alert] ='Доступ запрещен!'
			redirect_to root_url
		end	end 
	end	
	
end
