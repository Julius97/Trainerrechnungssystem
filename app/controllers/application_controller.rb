# encoding: utf-8
class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# protect_from_forgery with: :exception

	helper_method :mobile_device?
	after_action :setOnlineStatus

	def setOnlineStatus
 		if logged_in?
 			@current_user.update_attributes :last_seen_at => Time.now
 		end
 	end

	private

		def mobile_device?
			request.user_agent =~ /Mobile|webOS|Android|PlayBook|Kindle|Kindle Fire|Windows Phone/
		end

		def logged_in?
			return @current_user.present?
		end

		def check_session(needs_login_check,needs_admin_permissions)
	  		if needs_login_check
		  		if cookies.signed[:user_id]
				  	@current_user ||= User.find_by_id cookies.signed[:user_id]
				  	if @current_user
				  		if needs_admin_permissions
				  			if !@current_user.admin_permissions
				  				redirect_to dashboard_index_path
				  			end
				  		end
				  	else
				  		redirect_to logout_path
				  	end
				else
					redirect_to logout_path
				end
			else
				@current_user ||= User.find_by_id cookies.signed[:user_id] if cookies.signed[:user_id]
			end
		end

end
