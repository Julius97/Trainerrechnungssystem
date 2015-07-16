class Group < ActiveRecord::Base

	belongs_to :trainer
	belongs_to :accounting_group
	has_one :price
	has_many :groupclassifications
	has_many :trainingsplans

	validates :trainer_id, :presence => true

end