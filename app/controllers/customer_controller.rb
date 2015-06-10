class CustomerController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@customers = Customer.all.order(:last_name, :first_name)
	end

	def show
		if params[:id]
			if Customer.find_by_id params[:id]
				@customer = Customer.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
				redirect_to customer_index_path
			end
		else
			flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
			redirect_to customer_index_path
		end
	end

	def new

	end

	def create
		if !params[:first_name].blank? && !params[:last_name].blank?
			if Customer.where(:first_name => params[:first_name], :last_name => params[:last_name]).count == 0
				customer = Customer.create :first_name => params[:first_name], :last_name => params[:last_name]
				flash[:notice] = "Kunde " + customer.name + " wurde erfolgreich gespeichert"
			else
				flash[:error] = Customer.where(:first_name => params[:first_name], :last_name => params[:last_name]).first.name + " existiert bereits"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to customer_index_path
	end

	def edit
		if params[:id]
			if Customer.find_by_id params[:id]
				@customer = Customer.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
				redirect_to customer_index_path
			end
		else
			flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
			redirect_to customer_index_path
		end
	end

	def update
		if !params[:first_name].blank? && !params[:last_name].blank? && params[:customer_id]
			if Customer.where(:first_name => params[:first_name], :last_name => params[:last_name]).count == 0
				if Customer.find_by_id params[:customer_id]
					Customer.find_by_id(params[:customer_id]).update_attributes :first_name => params[:first_name], :last_name => params[:last_name]
					flash[:notice] = "Kunde " + Customer.find_by_id(params[:customer_id]).name + " wurde erfolgreich bearbeitet"
				else
					flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
				end
			else
				flash[:error] = "Kunde " + params[:first_name].to_s + " " + params[:last_name].to_s + " existiert bereits"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to customer_index_path
	end

	def destroy
		if params[:id]
			if Customer.find_by_id params[:id]
				flash[:notice] = "Kunde " + Customer.find_by_id(params[:id]).name + " wurde erfolgreich gelöscht"
				Customer.find_by_id(params[:id]).destroy
				redirect_to customer_index_path
			else
				flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
				redirect_to customer_index_path
			end
		else
			flash[:error] = "Fehler im System: Kunde konnte nicht gefunden werden"
			redirect_to customer_index_path
		end
	end

end