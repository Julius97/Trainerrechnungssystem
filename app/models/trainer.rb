class Trainer < ActiveRecord::Base

	belongs_to :user
	has_many :groups
	has_many :additional_trainings

	validates :user_id, :presence => true

end