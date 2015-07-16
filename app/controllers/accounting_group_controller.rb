class AccountingGroupController < ApplicationController

	before_action -> { check_session(true,false) }

	def new

	end

	def edit
		if params[:id]
			if AccountingGroup.find_by_id params[:id]
				@accounting_group = AccountingGroup.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
				redirect_to group_index_path
			end
		else
			flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
			redirect_to group_index_path
		end
	end

	def create
		if !params[:name].blank?
			if !AccountingGroup.find_by_name params[:name]
				AccountingGroup.create :name => params[:name]
				flash[:notice] = "Abrechnungsgruppe erfolgreich gespeichert!"
			else
				flash[:error] = "Abrechnungsgruppe " + params[:name] + " schon vorhanden" 
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to group_index_path
	end

	def update
		if !params[:accounting_group_id].blank? && !params[:name].blank?
			if AccountingGroup.find_by_id params[:accounting_group_id]
				acc_group = AccountingGroup.find_by_id params[:accounting_group_id]
				if acc_group.name != params[:name] && AccountingGroup.find_by_name(params[:name])
					flash[:error] = "Abrechnungsgruppe " + params[:name] + " schon vorhanden"
				else
					acc_group.update_attributes :name => params[:name]
					flash[:notice] = "Abrechnungsgruppe erfolgreich bearbeitet!"
				end
			else
				flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to group_index_path
	end

	def destroy
		if params[:id]
			if AccountingGroup.find_by_id params[:id]
				flash[:notice] = "Abrechnungsgruppe " + AccountingGroup.find_by_id(params[:id].to_i).name + " erfolgreich gelöscht"
				AccountingGroup.find_by_id(params[:id]).destroy
			else
				flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
		end
		redirect_to group_index_path
	end

end