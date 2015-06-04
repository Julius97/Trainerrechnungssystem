class TrainingController < ApplicationController

	before_action -> { check_session(true,false) }

	def create
		if !params[:group_id].blank? && !params[:customer].blank? && !params[:year].blank? && !params[:month].blank? && !params[:day].blank? && !params[:from_hour].blank? && !params[:from_min].blank? && !params[:to_hour].blank? && !params[:to_min].blank?
			training_start = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:from_hour].to_i, params[:from_min].to_i,0)
			training_end = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:to_hour].to_i, params[:to_min].to_i,0)
			if training_end > training_start
				if training_end < DateTime.now
					if Group.find_by_id params[:group_id]
						params[:customer].each do |key,value|
							if Groupclassification.where(:customer_id => key.to_i, :group_id => params[:group_id].to_i).count > 0
								groupclass = Groupclassification.where(:customer_id => key.to_i, :group_id => params[:group_id].to_i).first
								if value.to_i == 1
									Training.create :groupclassification_id => groupclass.id, :participated => 1, :training_start => training_start, :training_end => training_end
								else
									Training.create :groupclassification_id => groupclass.id, :participated => 0, :training_start => training_start, :training_end => training_end
								end
							end
						end
						flash[:notice] = "Training erfolgreich gespeichert"
					else
						flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
					end
				else
					flash[:error] = "Trainingsende muss in Vergangenheit liegen"
				end
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		if Group.find_by_id params[:group_id]
			redirect_to group_path params[:group_id]
		else
			redirect_to group_index_path
		end
	end

	def destroy
		if params[:id]
			if Training.find_by_id params[:id]
				training = Training.find_by_id params[:id]
				training.destroy
				flash[:notice] = "Training erfolgreich gelöscht"
			else
				flash[:error] = "Fehler im System: Training konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Training konnte nicht gefunden werden"
		end
		if training
			redirect_to group_path training.groupclass.group.id
		else
			redirect_to group_index_path
		end
	end

	def destroy_whole_training
		if !params[:start_time].blank? && !params[:end_time].blank? && !params[:group_id].blank?
			if Group.find_by_id params[:group_id]
				Training.where(:training_start => params[:start_time].to_datetime, :training_end => params[:end_time].to_datetime).each do |training|
					if training.groupclassification.group.id == params[:group_id].to_i
						training.destroy
					end
				end
				flash[:notice] = "Gesamtes Training erfolgreich gelöscht"
			else
				flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden, Training konnte nicht erkannt werden"
			end
		else
			flash[:error] = "Fehler im System: Training konnte nicht gefunden werden"
		end
		if Group.find_by_id params[:group_id]
			redirect_to group_path params[:group_id]
		else
			redirect_to group_index_path
		end
	end

end