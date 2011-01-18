require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
		@params = {:title => "Book name", 
							:autor => "Autor name",
							:price => 1.50,
							:available => true }
	end
	test "validates :autor" do
		@params[:autor] = nil
    book = Book.new(@params) 
		assert !book.save 
  end

	test "validates :title" do
		@params[:title] = nil
    book = Book.new(@params) 
		assert !book.save 
  end

	test "validates :price" do
		@params[:price] = nil
    book = Book.new(@params) 
		assert !book.save 
  end

	test "new book" do		
    book = Book.new(@params) 
		assert book.save
		assert_instance_of( String, book.title, "Некорректный тип")
		assert_instance_of( String, book.autor, "Некорректный тип")
		assert_instance_of( Float, book.price, "Некорректный тип")
		assert_instance_of( TrueClass, book.available, "Некорректный тип") 
  end	
	
	test "correct params length" do
		@params[:autor] = "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    book = Book.new(@params) 
		assert !book.save, "в autor можно вводить более 50 смволов"
		@params[:autor] = "qqqq"
		@params[:title] = "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    book = Book.new(@params) 
		assert !book.save, "в title можно вводить более 100 смволов"
  end
	
	test "correct :autor" do
		@params[:autor] = "342342323смчсм424234"
    book = Book.new(@params) 
		assert !book.save, "в autor можно вводить не только буквы"
  end

	test "correct :price" do
		@params[:price] = "яаявапапвапапяапва"
    book = Book.new(@params) 
		assert !book.save, "в price можно вводить буквы"
		@params[:price] = 0
    book = Book.new(@params) 
		assert !book.save, "price может быть = 0"
		@params[:price] = -11
    book = Book.new(@params) 
		assert !book.save, "price может быть отрицательной"
		@params[:price] = 457.1111111111111111111111111111111111111111
    book = Book.new(@params) 
		assert !book.save, "в price после \".\" можно вводить более 2 символов"
		
  end
end
