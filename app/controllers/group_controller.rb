class GroupController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@groups = Group.all.order(:name)
	end

	def show
		if params[:id]
			if Group.find_by_id params[:id]
				@group = Group.find_by_id params[:id]
				@price_per_lesson = @group.price.price_per_lesson
				@discount_per_lesson = @group.price.discount_per_lesson
			else
				flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
				redirect_to group_index_path
			end
		else
			flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
			redirect_to group_index_path
		end
	end

	def new

	end

	def create
		if !params[:name].blank? && !params[:trainer_id].blank?
			if !Group.find_by_name(params[:name]) && Trainer.find_by_id(params[:trainer_id].to_i)
				for_free = false
				for_free = true if !params[:for_free].blank?
				group = Group.create :name => params[:name], :trainer_id => params[:trainer_id].to_i, :for_free => for_free
				flash[:notice] = group.name + " erfolgreich erstellt"
			else
				flash[:error] = Group.find_by_name(params[:name]).name + " existiert bereits"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to group_index_path
	end

	def edit
		if params[:id]
			if Group.find_by_id params[:id]
				@group = Group.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
				redirect_to group_index_path
			end
		else
			flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
			redirect_to group_index_path
		end
	end

	def update
		if !params[:group_id]. blank? && !params[:name].blank? && !params[:trainer_id].blank?
			if Group.find_by_id params[:group_id]
				for_free = false
				for_free = true if !params[:for_free].blank?
				Group.find_by_id(params[:group_id]).update_attributes :trainer_id => params[:trainer_id].to_i, :name => params[:name], :for_free => for_free
				flash[:notice] = Group.find_by_id(params[:id]).name + " erfolgreich bearbeitet"
			else
				flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
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

	def add_customer_to_group
		if !params[:customer_id].blank? && !params[:group_id].blank?
			if Group.find_by_id(params[:group_id].to_i) && Customer.find_by_id(params[:customer_id].to_i)
				if Groupclassification.where(:group_id => params[:group_id].to_i, :customer_id => params[:customer_id].to_i).count == 0
					Groupclassification.create :group_id => params[:group_id].to_i, :customer_id => params[:customer_id].to_i
					flash[:notice] = "Gruppenzugehörigkeit erfolgreich gespeichert"
				else
					flash[:error] = "Gruppenzugehörigkeit des Spielers existiert bereits"
				end
			else
				flash[:error] = "Fehler im System: Gruppe oder Spieler konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		if Group.find_by_id(params[:group_id].to_i)
			redirect_to group_path params[:group_id]
		else
			redirect_to group_index_path
		end
	end

	def destroy
		if params[:id]
			if Group.find_by_id params[:id]
				flash[:notice] = Group.find_by_id(params[:id].to_i).name + " wurde erfolgreich gelöscht"
				Group.find_by_id(params[:id]).destroy
				redirect_to group_index_path
			else
				flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
				redirect_to group_index_path
			end
		else
			flash[:error] = "Fehler im System: Gruppe konnte nicht gefunden werden"
			redirect_to group_index_path
		end
	end
end