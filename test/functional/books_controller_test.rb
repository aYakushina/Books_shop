require 'test_helper'

class BooksControllerTest < ActionController::TestCase
 		include Devise::TestHelpers

	 setup do
    @book = books(:one)
		 @books = [books(:one), books(:two),books(:three),books(:four),books(:five),books(:six)]
		@contr = "books"
		sign_in users(:admin)
  end

	#тестирование action
	test "should get index" do  
		get :index
		assert_response :success
		@books.each do |book|
			assert assigns(:books).detect(book)
		end
  end

	test "should get seach result (autor)" do    
		get :index, {:request => 'Алёшина'}
		assert_response :success
		assert_equal [books(:one)], assigns(:books), "Поиск: не находит по автору"	
	end

	test "should get seach result (title)" do 	
		get :index, {:request => 'для менеджеров'}
		assert_equal [books(:one)], assigns(:books), "Поиск: не находит по названию"
	end
	
	test "should get seach result (autor & title)" do 
		get :index, {:request => 'Алёшина рилейшнз'}
		assert_equal [books(:one)], assigns(:books), "Поиск: не находит по автору и названию вместе"
	end

	test "should get seach result (registr)" do 
		get :index, {:request => 'aлёшина'}
		assert_equal [books(:one)], assigns(:books), "Поиск: зависит от регистра"
  end
	
	test "should get show" do  
		get :show, {:id => @books[1].id.to_s}
		assert_response :success
		assert_equal @books[1], assigns(:book)
  end

	test "should get new" do 				
		get :new
		assert_kind_of Book, assigns(:book)
		assert_template 'form'
  end

	test "should get create" do 
		post :create, {:book =>  {:autor => @books[1].autor,:title=> @books[1].title,:price=> @books[1].price,:available=> @books	[1].available}}
		assert_equal [@books[1].autor,@books[1].title,@books[1].price,@books[1].available], [assigns(:book).autor,assigns(:book).title,assigns(:book).price,assigns(:book).available]
		assert_redirected_to "/books/"+assigns(:book).id.to_s
		assert_equal 'Книга успешно создана', flash[:notice] 
  end

	test "should get edit" do 				
		get :edit, :id => @books[1]
		assert_kind_of Book, assigns(:book)
		assert_template 'form'
		assert_equal @books[1], assigns(:book)
  end

	test "should get update" do 
		put :update, {:id => @books[1].id, :book =>  {:autor => @books[2].autor,:title=> @books[2].title,:price=> @books[2].price,:available=> @books	[2].available}}
		assert_equal [@books[2].autor,@books[2].title,@books[2].price,@books[2].available], [assigns(:book).autor,assigns(:book).title,assigns(:book).price,assigns(:book).available]
		assert_redirected_to book_path(assigns(:book)) 
		assert_equal 'Книга успешно обновлена', flash[:notice] 
  end
	
	test "should get destroy" do 		
		delete :destroy, :id => @books[1]
		assert_redirected_to books_url
		get :index
		assert_equal [], assigns(:books).select {|book| book ==@books[1]}
  end

	#test "work with cart" do
		#не забыть про обработку удаления из заказа, в редактировании заказа
	#end
	
	# тестирование прав доступа и аутентификации
	test "should not get new" do 
  	sign_out users(:admin)
		get :new
		need_authenticate
		sign_in users(:user)				
		get :new		
		access_denied
  end

	test "should not get create" do 
		sign_out users(:admin)
		post :create, {:book =>  {:autor => @books[1].autor,:title=> @books[1].title,:price=> @books[1].price,:available=> @books	[1].available}}
		need_authenticate
		sign_in users(:user)
		post :create, {:book =>  {:autor => @books[1].autor,:title=> @books[1].title,:price=> @books[1].price,:available=> @books	[1].available}}
		access_denied
  end

	test "should not get edit" do 	
		sign_out users(:admin)
		get :edit, :id => @books[1]
		need_authenticate
		sign_in users(:user)			
		get :edit, :id => @books[1]
		access_denied
  end

	test "should not get update" do 
		sign_out users(:admin)
		put :update, {:id => @books[1].id, :book =>  {:autor => @books[2].autor,:title=> @books[2].title,:price=> @books[2].price,:available=> @books	[2].available}}
		need_authenticate
		sign_in users(:user)
		put :update, {:id => @books[1].id, :book =>  {:autor => @books[2].autor,:title=> @books[2].title,:price=> @books[2].price,:available=> @books	[2].available}}
		access_denied
  end
	
	test "should not get destroy" do 
		sign_out users(:admin)
		delete :destroy, :id => @books[1]
		need_authenticate
		sign_in users(:user)		
		delete :destroy, :id => @books[1]
		access_denied
  end


	#тестирование routes
	test "should route to books" do 
		check_routes '/books', @contr, "index" 
	end

	test "should route to create book" do 
		check_routes_with_method "/books", :post, @contr, "create"
	end

	test "should route to new book" do 
		check_routes '/books/new', @contr, "new"
	end

	test "should route to add book" do 
		check_routes '/books/add_book', @contr, "add_book" 
	end

	test "should route to del book" do 
		check_routes '/books/del_book', @contr, "del_book"
	end

	test "should route to show book" do 
		check_routes_with_id '/books/'+ @book.id.to_s,@contr, "show",  @book.id 
	end

	test "should route to edit book" do 
		check_routes_with_id '/books/' + @book.id.to_s + '/edit', @contr, "edit", @book.id
	end

	test "should route to update book" do 
		check_routes_with_id_and_method '/books/' + @book.id.to_s, :put, @contr, "update", @book.id
	end

	test "should route to destroy book" do 
		check_routes_with_id_and_method '/books/' + @book.id.to_s, :delete, @contr, "destroy",  @book.id	
	end
end
