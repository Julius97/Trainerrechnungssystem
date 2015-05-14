class Price < ActiveRecord::Base

	belongs_to :trainer

	validates :trainer_id, :presence => true
	validates :price_per_lesson, :presence => true
	validates :discount_per_lesson, :presence => true

end