class UserController < ApplicationController

	before_action -> { check_session(false,false) }

	def index
		if @current_user.admin_permissions
			@users = User.all.order(:last_name, :first_name)
		else
			redirect_to dashboard_index_path
		end
	end

	def new
		redirect_to dashboard_index_path if @current_user && !@current_user.admin_permissions
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
									if !params[:is_trainer].blank?
										Trainer.create :user_id => user.id
									end
									successful_registration = true
								end
							end
						end
					end
				end
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
				else
					redirect_to user_index_path
				end
			else
				redirect_to user_index_path
			end
		else
			redirect_to user_index_path
		end
	end

	def edit
		if params[:id]
			if User.find_by_id params[:id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					@user = User.find_by_id params[:id]
				else
					redirect_to user_index_path
				end
			else	
				redirect_to user_index_path
			end
		else
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
				end
			end
		end
		redirect_to user_index_path
	end

	def destroy 
		if params[:id]
			if User.find_by_id params[:id]
				if User.find_by_id(params[:id]).id == @current_user.id || @current_user.admin_permissions
					User.find_by_id(params[:id]).destroy
					redirect_to user_index_path
				else
					redirect_to user_index_path
				end
			else
				redirect_to user_index_path
			end
		else
			redirect_to user_index_path
		end
	end

end