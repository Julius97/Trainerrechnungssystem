class Customer < ActiveRecord::Base

	has_many :groupclassifications
	
	validates :first_name, :presence => true
	validates :last_name, :presence => true

	def name
		return self.first_name + " " + self.last_name
	end

end