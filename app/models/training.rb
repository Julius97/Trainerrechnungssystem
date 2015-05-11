class Training < ActiveRecord::Base

	belongs_to :groupclassification

	validates :groupclassification_id, :presence => true
	validates :training_start, :presence => true
	validates :training_end, :presence => true

end