class SessionController < ApplicationController

	before_action -> { check_session(false,false) }

	def index
		redirect_to dashboard_index_path if @current_user 
	end

	def create
		if !params[:mail_address].blank? && !params[:password].blank?
			user = User.authenticate(params[:mail_address],params[:password])
			if user
				if !params[:stay_logged_in].blank?
					cookies.permanent.signed[:user_id] = user.id
				else
					cookies.signed[:user_id] = user.id
				end
				redirect_to dashboard_index_path
			else
				flash[:error] = "Login fehlgeschlagen: Bitte überprüfen Sie E-Mail und Passwort und versuchen Sie es erneut"
				redirect_to login_path
			end
		else
			flash[:error] = "E-Mail und Passwort zum Login angeben"
			redirect_to login_path
		end
	end

	def destroy
		cookies.signed[:user_id] = nil
		flash[:notice] = "Logout erfolgreich"
		redirect_to login_path
	end

end