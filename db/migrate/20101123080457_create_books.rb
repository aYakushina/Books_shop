class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :autor
      t.string :title
      t.decimal :price, :precision => 8, :scale => 2
      t.boolean :available

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
