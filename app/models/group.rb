class Group < ActiveRecord::Base

	belongs_to :trainer
	has_many :groupclassifications

	validates :trainer_id, :presence => true

end