class SettingsController < ApplicationController

	before_action -> { check_session(true,true) }

	def index
		@online_users = User.online
	end

end