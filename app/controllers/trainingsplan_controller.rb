class TrainingsplanController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@groups = Group.all.order :name
	end

end