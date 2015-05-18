class DashboardController < ApplicationController

	before_action -> { check_session(true,false) }

	def index

	end

	def time_status
		time_status_str = ""
		time_status_str = Time.now.in_time_zone(Time.zone.name).strftime("%H:%M")
		render :html => time_status_str
	end

	def date_status
		date_status_str = ""
		date_status_str = Time.now.in_time_zone(Time.zone.name).strftime("%a, %B %y")
		render :html => date_status_str
	end
	
end