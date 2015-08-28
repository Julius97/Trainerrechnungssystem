class AdditionalTraining < ActiveRecord::Base

	belongs_to :trainer
	belongs_to :customer

	validates :price_per_hour, :presence => true
	validates :discount_per_hour, :presence => true
	validates :customer_id, :presence => true
	validates :trainer_id, :presence => true
	validates :training_id, :presence => true
	validates :training_start, :presence => true
	validates :training_end, :presence => true

end