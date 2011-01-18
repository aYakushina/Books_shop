class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.float :sum
      t.datetime :date
      t.string :payment
      t.string :delivery
      t.string :status, :default => 'В обработке'
      t.integer :user_id
      t.timestamps
    end
		  create_table :books_orders, :id => false do |t|
      t.integer :order_id
      t.integer :book_id
      t.timestamps
    end

  end

  def self.down
    drop_table :orders		
    drop_table :books_orders
  end

end
