class Cart
	attr_reader :items
	attr_reader :books

	def initialize 
		@items = []
		@books = []
	end

	def add_product(product_id) 
			@items << product_id
			@books << Book.find(product_id) 
	end
	
	def del_product(product_id) 
	
			@items.delete(product_id)
			@books.each do |product|
				@books.delete(product) if product.id.to_s==product_id
			end
	end

	def contains(product_id)
		if @items.select {|n| n==product_id} != []
			res = true
		else
			res = false
		end
	end
	
	def get_sum
		sum = 0.0
		@books.each do |book|
			sum += book.price
		end
		return sum
	end
	
end
