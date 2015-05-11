class Groupclassification < ActiveRecord::Base

	belongs_to :group
	belongs_to :customer
	has_many :trainings

	validates :group_id, :presence => true
	validates :customer_id, :presence => true

end