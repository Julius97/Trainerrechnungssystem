class TrainingsplanController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		if !mobile_device?
			@groups = Group.all.order :name
		else
			flash[:error] = "Zeitplan kann nur am Desktop-PC abgerufen werden!"
			redirect_to dashboard_index_path
		end
	end

	def create
		if !params[:group_id].blank? && !params[:wday].blank? && !params[:start].blank? && !params[:end].blank?
			start_time = Time.new(2015,1,1,params[:start].to_i,00,00,0)
			end_time = Time.new(2015,1,1,params[:end].to_i,00,00,0)
			Trainingsplan.create :group_id => params[:group_id].to_i, :wday => params[:wday].to_i, :start_time => start_time, :end_time => end_time
		end
		redirect_to :back
	end

	def clean_trainingsplan_before_update
		Trainingsplan.all.each do |entry|
			entry.destroy
		end
		redirect_to :back
	end

end