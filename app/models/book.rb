class Book < ActiveRecord::Base
	default_scope :order => 'title'
	validates :autor, :presence => true 
	validates_format_of :autor, :with => /\A[a-zA-Zа-яёА-ЯЁ\s\.]+\z/, :message => "Используйте только буквы, '.' и пробел" 
	validates_length_of :autor, :maximum => 50
	validates :title, :presence => true
	validates_length_of :title, :maximum => 100
	validates :price, :presence => true 
	validates_numericality_of :price, :greater_than => 0
	
	has_and_belongs_to_many :orders
end
