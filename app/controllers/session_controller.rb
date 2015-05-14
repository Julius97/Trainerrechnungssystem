class SessionController < ApplicationController

	before_action -> { check_session(false,false) }

	def index
		redirect_to dashboard_index_path if @current_user 
	end

	def create
		if !params[:mail_address].blank? && !params[:password].blank?
			user = User.authenticate(params[:mail_address],params[:password])
			if user
				cookies.signed[:user_id] = user.id
				redirect_to dashboard_index_path
			else
				redirect_to login_path
			end
		else
			redirect_to login_path
		end
	end

	def destroy
		cookies.signed[:user_id] = nil
		redirect_to login_path
	end

end