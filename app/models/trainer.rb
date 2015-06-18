class Trainer < ActiveRecord::Base

	belongs_to :user
	has_many :groups

	validates :user_id, :presence => true

end