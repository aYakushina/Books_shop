class AddDetailsToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :description, :text
    add_column :books, :cover, :string
  end

  def self.down
    remove_column :books, :cover
    remove_column :books, :description
  end
end
