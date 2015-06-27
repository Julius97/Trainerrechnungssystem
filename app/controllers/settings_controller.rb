class SettingsController < ApplicationController

	before_action -> { check_session(true,true) }

	def index
		@online_users = User.online
		@most_logins = [User.first,User.first,User.first]
		User.all.each do |user|
			if user.logins.count > @most_logins[0].logins.count
				@most_logins[0] = user
			elsif user.logins.count > @most_logins[1].logins.count
				@most_logins[1] = user
			elsif user.logins.count > @most_logins[2].logins.count
				@most_logins[2] = user
			end
		end
	end

end