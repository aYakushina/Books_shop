require 'test_helper'

class UserTest < ActiveSupport::TestCase   
	setup do
		@params = {:is_admin => true,
							 :username => "admin5",
							 :password => "123456",
							 :f_name => "Alyona",
							 :l_name => "Yakushina",
							 :email => "qq@primelabs.ru",
							 :telephone => "100",
							 :address => "Moscow" }
	end  

	test "new user" do
    user = User.new(@params) 
		assert user.save, "невозможно сохранить объект" 
  end

	test "validates :username" do
    @params[:username] = nil
    user = User.new(@params) 
		assert !user.save 
  end

	test "validates :password" do
    @params[:password] = nil
    user = User.new(@params) 
		assert !user.save 
  end

	test "validates :email" do
    @params[:email] = nil
    user = User.new(@params) 
		assert !user.save 
  end

	test "uniq :username" do
    user = User.new(@params) 
		assert user.save, "невозможно сохранить объект"
		user2 = User.new(@params)
		assert !user2.save, ":username не уникален" 
  end

	test "uniq :email" do
    user = User.new(@params) 
		assert user.save, "невозможно сохранить объект"
		user2 = User.new(@params)
		assert !user2.save, ":email не уникален" 
  end

	test "correct email" do
		@params[:email] = "dsfvsdsjdlksdlkvjskld"
    user = User.new(@params) 
		assert !user.save, "некорректно задается email"
		@params[:email] = "dsfvsdsjdlksdlkvjskld@thrthsrthsrt"
    user = User.new(@params) 
		assert !user.save, "некорректно задается email"
	
  end

	test "correct username" do
		@params[:username] = "*&^&*^&^&*^*&^*&"
    user = User.new(@params) 
		assert !user.save, "в username можно вводить не только буквы и цифры"
  end

	test "correct password.length" do
		@params[:password] = "aaaa"
		user = User.new(@params) 
		assert !user.save, "в password можно вводить <6 символов"
  end

	test "correct username.length" do
		@params[:username] = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		user = User.new(@params) 
		assert !user.save, "в username можно вводить >30 символов"
  end

	test "get user with orders" do
		user = User.new(@params)
		assert user.save
		order_params = {:sum => 200.0, 
							:date => "2010-11-23 11:06:52",
							:payment => "payment",
							:delivery => "delivery", 
							:status => "Status",
							:user_id => user.id }
		order = Order.new(order_params)
		user.orders << order
		assert user.save		
		user_saved = User.find(user.id)
		assert_equal( user_saved.orders, [order], "Некорректное сохранение связи пользователь-заказы")
  end

end
