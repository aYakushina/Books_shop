class Order < ActiveRecord::Base
	validates :sum, :presence => true
	validates_numericality_of :sum, :greater_than => 0 
	validates :date, :presence => true 
	validates :payment, :presence => true 
	validates :delivery, :presence => true 
	validates :status, :presence => true 
	validates :user_id, :presence => true 

	belongs_to :users
	has_and_belongs_to_many :books
	
end
