class BooksController<ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show,  :search]
	before_filter :admin_authenticate, :except => [:index, :show, :search, :add_book , :del_book ] 
	
	# GET /books
  # GET /books.xml
  def index
		num = 5
		
    if params[:request]!= nil or params[:available]=="1" then
			search
			@listing =	@books.count%num == 0? @books.count/num : @books.count/num+1  
			listing_search num
			@search = params[:request]
			@search_available = params[:available]
		else
			listing num
			@listing =	Book.count%num == 0? Book.count/num : Book.count/num+1  
			@search = ""	
			@search_available = 0	
		end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])
		@added = false
		@cart = find_cart
		if @cart.contains(params[:id]) 
				@added = true 
		end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    respond_to do |format|
      format.html # new.html.erb
     format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Книга успешно создана') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Книга успешно обновлена') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end

	def add_book 
		@cart = find_cart
		if @cart.contains(params[:id]) 
			flash[:notice] = 'Эта книга уже добавлена'
		else
			@cart.add_product(params[:id]) 
		end		 
  end

	def del_book  
		@cart = find_cart
		@cart.del_product(params[:id]) 
		redirect_to("/orders/new")
  end

private
	
  def search  
	list_of_books = Book.where ["title LIKE ? OR autor LIKE ?", '%' + params[:request] + '%', '%' + params[:request] + '%']
			
	if list_of_books != nil
		if params[:available]=="1"
   		#@books = list_of_books.select {|e| e.available==true}
			@books = list_of_books.where ["available LIKE ?", true] 
		else
   		@books = list_of_books
		end
	end

  end

	def listing	num
			if 	params[:number]!=nil	
					@books = Book.limit(num).offset(params[:number].to_i*num) 
			else
					@books = Book.limit(num)
			end
	end	
	
	def listing_search num
			if 	params[:number]!=nil	
					@books = @books.limit(num).offset(params[:number].to_i*num) 
			else
					@books = @books.limit(num)
			end
	end	


end
