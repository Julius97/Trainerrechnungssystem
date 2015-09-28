class UserController < ApplicationController

	before_action -> { check_session(false,false) }

	def index
		if @current_user.admin_permissions
			@users = User.all.order(:last_name, :first_name)
		else
			flash[:error] = "Sie verfügen über keine Berechtigung, die Benutzerliste einzusehen"
			redirect_to dashboard_index_path
		end
	end

	def new
		if @current_user && !@current_user.admin_permissions
			flash[:error] = "Sie haben nur auf die Registrierungsseite Zugriff, wenn sie ausgeloggt sind"
			redirect_to dashboard_index_path
		end
	end

	def create
		if !@current_user || @current_user.admin_permissions
			successful_registration = false
			if params[:last_name] && params[:first_name] && params[:mail] && params[:repeated_mail] && params[:password] && params[:repeated_password]
				if !params[:first_name].blank? && !params[:last_name].blank? && !params[:mail].blank? && !params[:repeated_mail].blank? && !params[:password].blank? && !params[:repeated_password].blank?
				    if params[:mail] == params[:repeated_mail]
				    	if params[:password] == params[:repeated_password]
				    		if !User.find_by_mail_address(params[:mail])
				    			if User.where(:last_name => params[:last_name], :first_name => params[:first_name]).count == 0
									user = User.create :password => params[:password], :last_name => params[:last_name], :first_name => params[:first_name], :admin_permissions => false, :mail_address => params[:mail]
									flash[:notice] = "Nutzer " + user.name + " wurde erfolgreich gespeichert"
									if !params[:is_trainer].blank?
										Trainer.create :user_id => user.id
									end
									successful_registration = true
								else
									flash[:error] = "Nutzer " + User.where(:last_name => params[:last_name], :first_name => params[:first_name]).first.name + " existiert bereits"
								end
							else
								flash[:error] = "Mailadresse wird bereits von einem User genutzt"
							end
						else
							flash[:error] = "Passwörter stimmen nicht überein"
						end
					else
						flash[:error] = "Mailadressen stimmen nicht überein"
					end
				else
					flash[:error] = "Bitte alle Felder ausfüllen"
				end
			else
				flash[:error] = "Bitte alle Felder ausfüllen"
			end
			if successful_registration
				redirect_to login_path
			else
				redirect_to register_path
			end
		else
			redirect_to dashboard_index_path
		end
	end

	def show
		if params[:id]
			if User.find_by_id params[:id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					@user = User.find_by_id params[:id]
					if @user.trainer
						if AccountingPeriod.find_by_id(params[:acc_period_id])
							@groups = @user.trainer.groups
							if AccountingPeriod.find_by_id(params[:acc_period_id]).accounting_group.name == "Vereinstraining"
								@additional_trainings_ids = @user.trainer.additional_trainings.where("training_start >= ? AND training_end <= ?",AccountingGroup.find_by_name("Vereinstraining").accounting_periods.find_by_id(params[:acc_period_id]).start_date.to_datetime, AccountingGroup.find_by_name("Vereinstraining").accounting_periods.find_by_id(params[:acc_period_id]).end_date.to_datetime).pluck(:training_id)
								@additional_trainings_ids = @additional_trainings_ids.uniq{|x| x}
							else
								@additional_trainings_ids = @user.trainer.additional_trainings.where("training_start >= ? AND training_end <= ?",AccountingGroup.find_by_name("Vereinstraining").actual_acc_period.start_date.to_datetime, AccountingGroup.find_by_name("Vereinstraining").actual_acc_period.end_date.to_datetime).pluck(:training_id)
								@additional_trainings_ids = @additional_trainings_ids.uniq{|x| x}
							end
						else
							flash[:error] = "Dieser Nutzer ist ein Trainer und benötigt daher einen Abrechnungszeitraum"
							redirect_to user_index_path
						end
					end
				else
					flash[:error] = "Fremdes Nutzerprofil angefordert. Sie verfügen über keine Berechtigung für diese Aktion"
					redirect_to user_index_path
				end
			else
				flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
				redirect_to user_index_path
			end
		else
			flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
			redirect_to user_index_path
		end
	end

	def edit
		if params[:id]
			if User.find_by_id params[:id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					@user = User.find_by_id params[:id]
				else
					flash[:error] = "Fremdes Nutzerprofil angefordert. Sie verfügen über keine Berechtigung für diese Aktion"
					redirect_to user_index_path
				end
			else	
				flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
				redirect_to user_index_path
			end
		else
			flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
			redirect_to user_index_path
		end
	end

	def update
		if !params[:first_name].blank? && !params[:last_name].blank? && !params[:mail].blank? && !params[:user_id].blank?
			if User.find_by_id params[:user_id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					admin_permissions = false
					admin_permissions = true if !params[:admin_permissions].blank?
					is_trainer = false
					is_trainer = true if !params[:is_trainer].blank?
					User.find_by_id(params[:id]).update_attributes :last_name => params[:last_name], :first_name => params[:first_name], :admin_permissions => admin_permissions, :mail_address => params[:mail]
					if User.find_by_id(params[:id]).trainer && !is_trainer
						User.find_by_id(params[:id]).trainer.destroy
					elsif !User.find_by_id(params[:id]).trainer && is_trainer
						Trainer.create :user_id => params[:user_id].to_i
					end
					flash[:notice] = "Nutzer " + User.find_by_id(params[:id]).name + "erfolgreich bearbeitet"
				else
					flash[:error] = "Fremdes Nutzerprofil versucht zu bearbeiten. Sie verfügen über keine Berechtigung für diese Aktion"
				end
			else
				flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
			end
		else
			flash[:error] = "Bitte alle Felder ausfüllen"
		end
		redirect_to user_index_path
	end

	def destroy 
		if params[:id]
			if User.find_by_id params[:id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					flash[:notice] = "Nutzer " + User.find_by_id(params[:id]).name + "erfolgreich gelöscht"
					User.find_by_id(params[:id]).destroy
					redirect_to user_index_path
				else
					flash[:error] = "Fremdes Nutzerprofil versucht zu löschen. Sie verfügen über keine Berechtigung für diese Aktion"
					redirect_to user_index_path
				end
			else
				flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
				redirect_to user_index_path
			end
		else
			flash[:error] = "Fehler im System: Nutzer konnte nicht gefunden werden"
			redirect_to user_index_path
		end
	end

end