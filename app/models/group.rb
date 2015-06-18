class Group < ActiveRecord::Base

	belongs_to :trainer
	has_one :price
	has_many :groupclassifications

	validates :trainer_id, :presence => true

end