class ContactController < ApplicationController

	before_action -> { check_session(false,false) }

	def new

	end

	def create

	end

end