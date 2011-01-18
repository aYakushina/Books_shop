require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
		include Devise::TestHelpers
		include ApplicationHelper
  
	setup do
		@contr = "orders"
		sign_in users(:admin)
		@cart = find_cart
		@cart.add_product(books(:one)) 
		@cart.add_product(books(:two)) 
		@sum = (books(:one).price + books(:two).price)
		post :create, {:order => {:sum => @sum, :payment => "payment", :delivery => "delivery", :status => "status"}}
		@admin_order = assigns(:order)
  end

	
	#тестирование action
	
	test "should get new order" do  
		@cart = find_cart
		@cart.add_product(books(:one)) 
		@cart.add_product(books(:two)) 
		get :new
		assert_response :success, "not success :new"
		assert_equal @sum, assigns(:order).sum, "неверно рассчитывается сумма"
		assert_equal [nil, nil,nil,nil,nil,nil,nil], [assigns(:order).id, assigns(:order).date, assigns(:order).payment, assigns(:order).delivery, assigns(:order).user_id, assigns(:order).created_at, assigns(:order).updated_at], "некорректно работает :new"
	end

	test "should create order" do 
		 	#	post :create в setup 
		assert_not_nil  assigns(:order), "assigns(:order) = nil"
		assert_equal 'Заказ успешно отправлен', flash[:notice], "некорректное flash[:notice]"
		assert_equal [], find_cart.items, "session[:cart] не очищается"
		assert_equal @cart.books, assigns(:order).books, "список книг не привязывается к заказу"
		assert_redirected_to "/orders/"+assigns(:order).id.to_s, "после создания не перенаправляется на страницу заказа"
  end
	
	
	test "should get index" do 
		sign_out users(:admin) 
		sign_in users(:user) 
		@cart = find_cart
		@cart.add_product(books(:one)) 
		post :create, {:order => {:sum => @sum, :payment => "payment2", :delivery => "delivery2", :status => "status2"}}
		user_order = assigns(:order)
		get :index
		assert_response :success
	 	assert_equal  [user_order], assigns(:orders)
		sign_in users(:admin) 
		get :index
		assert_response :success
	 	assert assigns(:orders).detect(	@admin_order)
		assert assigns(:orders).detect(user_order)
	end

	test "should show order" do 
		get :show, {:id => @admin_order.id}
		assert_equal  @admin_order, assigns(:order), "некорректно находт книгу в бд"
		assert_equal  @admin_order.books, assigns(:order).books, "некорректный список книг"
	end

	test "should edit order" do 
		get :edit, {:id => @admin_order.id}
		assert_equal  @admin_order, assigns(:order), "некорректно находт книгу в бд"
		assert_equal  @admin_order.books, assigns(:order).books, "некорректный список книг"
	end
	
	test "should update order" do 
		#можно редактировать заказ, только если статус - "В обработке"
		put :update, {:id => @admin_order.id, :order => {:status => 'Принят'}}
		assert_redirected_to '/orders/'+ 	@admin_order.id.to_s, "после обновления не перенаправляется на страницу заказа"
		assert_equal 'Заказ успешно обновлен', flash[:notice], "некорректное flash[:notice]"
		assert_equal 'Принят', assigns(:order).status, "не сохраняется измененное значение"
		put :update, {:id => @admin_order.id, :order => {:payment => 'new_payment'}}
		assert_not_equal 'new_payment', assigns(:order).payment, "сохраняется измененное значение при статусе 'Принят'"
		assert_equal "Невозможно изменить заказ в статусе 'Принят'", flash[:notice], "некорректное flash[:notice]"
	end

	test "should destroy order" do 
		#можно удалять заказ, только если статус - "В обработке"
		put :update, {:id => @admin_order.id, :order => {:status => 'Принят'}}
		delete :destroy, {:id => @admin_order.id}
		get :index		
		assert !assigns(:orders).detect(@admin_order), "заказ удаляется в статусе 'Принят'"
		assert_equal "Невозможно удалить заказ в статусе 'Принят'", flash[:notice], "некорректное flash[:notice]"
	end

	# тестирование прав доступа и аутентификации

	test "should not get new" do 
  	sign_out users(:admin)		
		get :new
		assert_redirected_to "/users/sign_in"
  end

	test "should not create order" do 
		sign_out users(:admin)
		post :create, {:order => {:sum => @sum, :payment => "payment", :delivery => "delivery", :status => "status"}}
		assert_redirected_to "/users/sign_in"
  end

	test "should not get index"do 
		sign_out users(:admin)
		get :index
		assert_redirected_to "/users/sign_in"
  end

	test "should not show order"do 
		sign_out users(:admin)
		get :show, {:id => @admin_order.id}
		assert_redirected_to "/users/sign_in"
		sign_in users(:user)
		get :show, {:id => @admin_order.id}
		access_denied
  end

	test "should not edit order"do 
		sign_out users(:admin)
		get :edit, {:id => @admin_order.id}
		assert_redirected_to "/users/sign_in"
		sign_in users(:user)
		get :edit, {:id => @admin_order.id}
		access_denied
  end

	test "should not update order"do 
		sign_out users(:admin)
		put :update, {:id => @admin_order.id, :order => {:payment => 'payment'}}
		assert_redirected_to "/users/sign_in"
		sign_in users(:user)
		put :update, {:id => @admin_order.id, :order => {:status => 'Принят'}}
		access_denied 	
  end

	test "should not destroy order"do 
		sign_out users(:admin)
		delete :destroy, {:id => @admin_order.id}
		assert_redirected_to "/users/sign_in"
		sign_in users(:user)
		delete :destroy, {:id => @admin_order.id}
		access_denied
  end

	#тестирование routes

	test "should route to orders" do 
		check_routes '/orders', @contr, "index" 
	end

	test "should route to create orders" do 
		check_routes_with_method "/orders", :post, @contr, "create"
	end

	test "should route to new orders" do 
		check_routes '/orders/new', @contr, "new"
	end

	test "should route to show orders" do 
		check_routes_with_id '/orders/'+ 	@admin_order.id.to_s,@contr, "show",  	@admin_order.id 
	end

	test "should route to edit orders" do 
		check_routes_with_id '/orders/' +	@admin_order.id.to_s + '/edit', @contr, "edit", 	@admin_order.id
	end

	test "should route to update orders" do 
		check_routes_with_id_and_method '/orders/' + 	@admin_order.id.to_s, :put, @contr, "update", 	@admin_order.id
	end

	test "should route to destroy orders" do 
		check_routes_with_id_and_method '/orders/' + 	@admin_order.id.to_s, :delete, @contr, "destroy",  	@admin_order.id	
	end

end
