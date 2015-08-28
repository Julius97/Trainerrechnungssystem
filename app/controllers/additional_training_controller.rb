class AdditionalTrainingController < ApplicationController

	before_action -> { check_session(true,false) }

	def new

	end

	def create
		if !params[:price_per_hour].blank? && !params[:discount_per_hour].blank? && !params[:trainer_id].blank? && !params[:customer].blank? && !params[:year].blank? && !params[:month].blank? && !params[:day].blank? && !params[:from_hour].blank? && !params[:from_min].blank? && !params[:to_hour].blank? && !params[:to_min].blank?
			training_start = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:from_hour].to_i, params[:from_min].to_i,0)
			training_end = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:to_hour].to_i, params[:to_min].to_i,0)
			training_id = 1
			if AdditionalTraining.count > 0
				training_id = AdditionalTraining.last.training_id.to_i + 1
			end
			if Trainer.find_by_id(params[:trainer_id])
				if params[:price_per_hour].to_i > 0 && params[:price_per_hour].to_i >= params[:discount_per_hour].to_i
					if training_end > training_start
						if training_end < DateTime.now + DateTime.now.utc_offset
							params[:customer].each do |key,value|
								if value.to_i == 1
									if Customer.find_by_id(key.to_i)
										AdditionalTraining.create :trainer_id => params[:trainer_id].to_i, :customer_id => key.to_i, :training_start => training_start, :training_end => training_end, :price_per_hour => params[:price_per_hour].to_i, :discount_per_hour => params[:discount_per_hour].to_i, :training_id => training_id
									end
								end
							end
							flash[:notice] = "Zusatztraining erfolgreich gespeichert"
						else
							flash[:error] = "Trainingsende muss in Vergangenheit liegen"
						end
					end
				else
					flash[:error] = "Zuschuss darf nicht kleiner 0 € sein, Preis muss größer 0 € sein und darf nicht weniger als der Zuschuss sein!"
				end
			else
				flash[:error] = "Fehler im System: Trainer konnte nicht gefunden werden"
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

	def show
		if params[:id]
			if AdditionalTraining.find_by_id params[:id]
				@additional_training = AdditionalTraining.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Zusatztraining konnte nicht gefunden werden"
				redirect_to price_index_path
			end
		else
			flash[:error] = "Fehler im System: Zusatztraining konnte nicht gefunden werden"
			redirect_to group_index_path
		end
	end

	def destroy
		if params[:id]
			if AdditionalTraining.find_by_training_id params[:id]
				AdditionalTraining.where(:training_id => AdditionalTraining.find_by_training_id(params[:id]).training_id).each do |at|
					at.destroy
				end
				flash[:notice] = "Zusatztraining erfolgreich gelöscht"
			else
				flash[:error] = "Fehler im System: Zusatztraining konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Zusatztraining konnte nicht gefunden werden"
		end
		redirect_to group_index_path
	end

end