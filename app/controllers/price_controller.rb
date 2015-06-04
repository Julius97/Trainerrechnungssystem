class PriceController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@prices = Price.all.order(:trainer_id)
	end

	def show
		if params[:id]
			if Price.find_by_id params[:id]
				@price = Price.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
				redirect_to price_index_path
			end
		else
			flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
			redirect_to price_index_path
		end
	end

	def new

	end

	def create
		if !params[:price_per_lesson].blank? && !params[:discount_per_lesson].blank? && !params[:trainer_id].blank?
			if Trainer.find_by_id(params[:trainer_id].to_i)
				if !Price.find_by_trainer_id(params[:trainer_id].to_i)
					if params[:price_per_lesson].to_i >= 0 && params[:discount_per_lesson].to_i >= 0
						if params[:price_per_lesson].to_i >= params[:discount_per_lesson].to_i
							Price.create :trainer_id => params[:trainer_id].to_i, :discount_per_lesson => params[:discount_per_lesson].to_i, :price_per_lesson => params[:price_per_lesson].to_i
							flash[:notice] = "Preis wurde erfolgreich erstellt"
						else
							flash[:error] = "Der Vereinszuschuss darf nicht größer als der Trainerpreis sein"
						end
					else
						flash[:error] = "Der Preis und der Zuschuss darf nicht kleiner 0€ sein"
					end
				else
					flash[:error] = "Für diesen Trainer liegt bereits ein Preis vor. Wenn dieser verändert werden soll, kann der Preis nachträglich bearbeitet werden"
				end
			else
				flash[:error] = "Fehler im System: Trainer konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to price_index_path
	end

	def edit
		if params[:id]
			if Price.find_by_id params[:id]
				@price = Price.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
				redirect_to price_index_path
			end
		else
			flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
			redirect_to price_index_path
		end
	end

	def update
		if !params[:price_per_lesson].blank? && !params[:discount_per_lesson].blank? && !params[:price_id].blank?
			if Price.find_by_id(params[:price_id].to_i)
				if params[:price_per_lesson].to_i > 0 && params[:discount_per_lesson].to_i >= 0
					if params[:price_per_lesson].to_i >= params[:discount_per_lesson].to_i
						Price.find_by_id(params[:price_id].to_i).update_attributes :discount_per_lesson => params[:discount_per_lesson].to_i, :price_per_lesson => params[:price_per_lesson].to_i
						flash[:notice] = "Preis von " + Price.find_by_id(params[:price_id].to_i).trainer.user.name + " erfolgreich bearbeitet"
					else
						flash[:error] = "Der Vereinszuschuss darf nicht größer als der Trainerpreis sein"
					end
				else
					flash[:error] = "Der Preis und der Zuschuss darf nicht kleiner 0€ sein"
				end
			else
				flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		if Price.find_by_id(params[:price_id].to_i)
			redirect_to price_path(Price.find_by_id(params[:price_id].to_i).id)
		else
			redirect_to price_index_path
		end
	end

	def destroy
		if params[:id]
			if Price.find_by_id params[:id]
				flash[:notice] = "Preis von " + Price.find_by_id(params[:price_id].to_i).trainer.user.name + " erfolgreich gelöscht"
				Price.find_by_id(params[:id]).destroy
			else
				flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Fehler im System: Preis konnte nicht gefunden werden"
		end
		redirect_to price_index_path
	end

end