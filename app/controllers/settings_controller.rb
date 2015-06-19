class SettingsController < ApplicationController

	before_action -> { check_session(true,true) }

	def index

	end

end