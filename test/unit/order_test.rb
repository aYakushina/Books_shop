require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	setup do
		@params = {:sum => 200.0, 
							:date => "2010-11-23 11:06:52",
							:payment => "payment",
							:delivery => "delivery", 
							:status => "Status",
							:user_id => 1 }
	end
  test "validates :sum" do
		@params[:sum] = nil
    order = Order.new(@params) 
		assert !order.save 
  end

	test "validates :payment" do
		@params[:payment] = nil
    order = Order.new(@params) 
		assert !order.save 
  end
	
	test "validates :delivery" do
		@params[:delivery] = nil
    order = Order.new(@params) 
		assert !order.save 
  end

	test "validates :status" do
		@params[:status] = nil
    order = Order.new(@params) 
		assert !order.save 
  end
	
	test "validates :user_id" do
		@params[:user_id] = nil
    order = Order.new(@params) 
		assert !order.save 
  end
	
	test "validates :date" do
		@params[:date] = nil
    order = Order.new(@params) 
		assert !order.save 
  end
 
	test "new order" do
    order = Order.new(@params) 
		assert order.save 
		assert_instance_of( Float, order.sum, "Некорректный тип")
		assert_instance_of( ActiveSupport::TimeWithZone, order.date, "Некорректный тип")
		assert_instance_of( String, order.payment, "Некорректный тип")
		assert_instance_of( String, order.delivery, "Некорректный тип")
		assert_instance_of( String, order.status, "Некорректный тип")
		assert_instance_of( Fixnum, order.user_id, "Некорректный тип")
  end

	test "get order with books" do
    order = Order.new(@params) 
		book_params = {:title => "Book name", 
							:autor => "Autor name",
							:price => 1.50,
							:available => true }
		book = Book.new(book_params)
		order.books << book
		assert order.save
		oreder_saved = Order.find(order.id)
		assert_equal( oreder_saved.books, [book], "Некорректное сохранение связи заказ-книги")
  end

	
end
