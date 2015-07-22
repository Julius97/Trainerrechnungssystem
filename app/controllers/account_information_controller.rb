class AccountInformationController < ApplicationController

	before_action -> { check_session(true,false) }

	def create
		if !params[:account_number].blank? && !params[:bank_code].blank? && !params[:iban].blank? && !params[:bic].blank? && !params[:credit_institution].blank? && !params[:user_id].blank?
			if User.find_by_id(params[:user_id].to_i)
				AccountInformation.create :user_id => params[:user_id].to_i, :account_number => params[:account_number], :bank_code => params[:bank_code], :bic => params[:bic], :iban => params[:iban], :credit_institution => params[:credit_institution]
				flash[:notice] = "Kontoverbindung erfolgreich gespeichert"
			else
				flash[:error] = "Fehler im System: Konto-Inhaber konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder der Kontoverbindung ausfüllen!"
		end
		redirect_to user_path(params[:user_id].to_i)
	end

	def edit
		if params[:id]
			if AccountInformation.find_by_id params[:id]
				@account_information = AccountInformation.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Kontoverbindung konnte nicht gefunden werden"
				redirect_to user_index_path
			end
		else
			flash[:error] = "Fehler im System: Kontoverbindung konnte nicht gefunden werden"
			redirect_to user_index_path
		end
	end

	def update
		if !params[:account_number].blank? && !params[:bank_code].blank? && !params[:iban].blank? && !params[:bic].blank? && !params[:credit_institution].blank? && !params[:account_information_id].blank?
			if AccountInformation.find_by_id(params[:account_information_id].to_i)
				AccountInformation.find_by_id(params[:account_information_id].to_i).update_attributes :account_number => params[:account_number], :bank_code => params[:bank_code], :bic => params[:bic], :iban => params[:iban], :credit_institution => params[:credit_institution]
				flash[:notice] = "Kontoverbindung erfolgreich bearbeitet"
			else
				flash[:error] = "Fehler im System: Zu bearbeitende Kontoverbindung konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder der Kontoverbindung ausfüllen!"
		end
		redirect_to user_path(params[:user_id].to_i)
	end

	def destroy
		if params[:id]
			if AccountInformation.find_by_id params[:id]
				flash[:notice] = "Kontoverbindung erfolgreich gelöscht"
				AccountInformation.find_by_id(params[:id]).destroy
			else
				flash[:error] = "Fehler im System: Kontoverbindung konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Kontoverbindung konnte nicht gefunden werden"
		end
		redirect_to user_index_path
	end

end