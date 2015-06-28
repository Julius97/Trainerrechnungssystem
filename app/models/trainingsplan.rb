class Trainingsplan < ActiveRecord::Base

	belongs_to :group

	validates :group_id, :presence => true
	validates :start_time, :presence => true
	validates :end_time, :presence => true
	validates :wday, :presence => true

end