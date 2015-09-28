class AccountingPeriodController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@acc_periods = AccountingPeriod.all.order(:accounting_group_id)
	end

	def show
		if params[:id]
			if AccountingPeriod.find_by_id params[:id]
				@acc_period = AccountingPeriod.find_by_id params[:id]
			else
				flash[:error] = "Fehler im System: Abrechnungszeitraum konnte nicht gefunden werden"
				redirect_to group_index_path
			end
		else
			flash[:error] = "Fehler im System: Abrechnungszeitraum konnte nicht gefunden werden"
			redirect_to accounting_period_index_path
		end
	end

	def new

	end

	def create
		if !params[:acc_group_id].blank? && !params[:from_year].blank? && !params[:from_month].blank? && !params[:from_day].blank? && !params[:to_year].blank? && !params[:to_month].blank? && !params[:to_day].blank?
			start_date = Date.new(params[:from_year].to_i, params[:from_month].to_i, params[:from_day].to_i)
			end_date = Date.new(params[:to_year].to_i, params[:to_month].to_i, params[:to_day].to_i)
			if start_date < end_date
				if AccountingGroup.find_by_id params[:acc_group_id]
					AccountingPeriod.create :start_date => start_date, :end_date => end_date, :accounting_group_id => params[:acc_group_id].to_i
				else
					flash[:error] = "Fehler im System: Abrechnungsgruppe konnte nicht gefunden werden"
				end
			else
				flash[:error] = "Startdatum muss vor Abschlussdatum liegen!"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end

		redirect_to accounting_period_index_path
	end

	def edit

	end

	def update

	end

	def destroy

	end

end
