class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, :presence => true
	validates_format_of :username, :with => /\A[a-zA-Zа-яА-Я0-9\s]+\z/, :message => "Используйте только буквы, цифры и пробел" 
	validates_uniqueness_of :username,
  :message => "Уже есть пользователь с таким логином" 
	validates_length_of :username, :maximum => 30 	
  # Setup accessible (or protected) attributes for your model
  			  attr_accessible :is_admin, :f_name, :l_name, :telephone, :address, :username, :email, :password, :password_confirmation, :remember_me
	
	has_many :orders
end
