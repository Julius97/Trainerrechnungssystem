class Customer < ActiveRecord::Base

	has_many :groupclassifications
	
	validates :first_name, :presence => true
	validates :last_name, :presence => true

end