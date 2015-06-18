class Price < ActiveRecord::Base

	belongs_to :group

	validates :group_id, :presence => true
	validates :price_per_lesson, :presence => true
	validates :discount_per_lesson, :presence => true

end