class Group < ActiveRecord::Base

	belongs_to :trainer
	has_one :price
	has_many :groupclassifications
	has_many :trainingsplans

	validates :trainer_id, :presence => true

end