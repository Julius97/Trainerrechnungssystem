class Trainer < ActiveRecord::Base

	belongs_to :user
	has_many :groups
	has_one :price

	validates :user_id, :presence => true

end