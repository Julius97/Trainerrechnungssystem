class GroupclassificationController < ApplicationController

	before_action -> { check_session(true,false) }

	def destroy
		if params[:id]
			if Groupclassification.find_by_id params[:id]
				flash[:notice] = "Gruppenzugehörigkeit erfolgreich aufgelöst"
				Groupclassification.find_by_id(params[:id]).destroy
			else
				flash[:error] = "Fehler im System: Gruppenzugehörigkeit des Spielers konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Gruppenzugehörigkeit des Spielers konnte nicht gefunden werden"
		end
		redirect_to group_index_path
	end

end