module ApplicationHelper
	def find_cart
		session[:cart] ||= Cart.new
	end
	
	def delete_cart
		session[:cart] = nil
	end

	
end
