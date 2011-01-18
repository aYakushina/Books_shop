class OrdersController < ApplicationController
 before_filter :authenticate_user!

  # GET /orders
  # GET /orders.xml
  def index
		if current_user.is_admin?    
			@orders = Order.all
		else
			show_office
		end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
		
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
		@order = Order.new
		get_order_sum
		@order = Order.new({:sum => @sum})		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
		@books = @order.books
  end

  # POST /orders
  # POST /orders.xml
  def create
		params[:order][:user_id] = current_user.id
		params[:order][:date] = Time.now
		@order = Order.new(params[:order])
		@cart = find_cart
		@order.books = @cart.books
	  respond_to do |format|
      if @order.save 
				delete_cart
        format.html { redirect_to(@order, :notice => 'Заказ успешно отправлен') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
	
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Заказ успешно обновлен') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

	def show_office
		@orders = User.find(current_user.id).orders
	end

	def del_cart
		delete_cart
		redirect_to("/books/")
	end
	
private

	def get_order_sum				
		@cart = find_cart	
		@order.books = @cart.books
		@books = @order.books
		@sum = @cart.get_sum
	end	
end
