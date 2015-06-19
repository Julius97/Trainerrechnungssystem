class ContactController < ApplicationController

	before_action -> { check_session(false,false) }

	def new

	end

	def create
		if !params[:first_name].blank? && !params[:last_name].blank? && !params[:mail].blank? && !params[:subject].blank? && !params[:message].blank?
			ContactMailer.send_contact_form(params[:first_name], params[:last_name], params[:mail], params[:subject], params[:message]).deliver
			flash[:notice] = "Formular wurde erfolgreich an Seitenbetreiber übermittelt. Antwort erhalten Sie in nächster Zeit an " + params[:mail]
			redirect_to contact_path
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
			redirect_to contact_path
		end
	end

end