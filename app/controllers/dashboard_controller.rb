class DashboardController < ApplicationController

	before_action -> { check_session(true,false) }

	def index

	end
	
end