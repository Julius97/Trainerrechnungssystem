class GroupController < ApplicationController

	before_action -> { check_session(true,false) }

	def index
		@groups = Group.all.order(:name)
	end

	def show
		if params[:id]
			if Group.find_by_id params[:id]
				@group = Group.find_by_id params[:id]
				@price_per_lesson = @group.trainer.price.price_per_lesson
				@discount_per_lesson = @group.trainer.price.discount_per_lesson
			else
				redirect_to group_index_path
			end
		else
			redirect_to group_index_path
		end
	end

	def new

	end

	def create
		if !params[:name].blank? && !params[:trainer_id].blank?
			if !Group.find_by_name(params[:name]) && Trainer.find_by_id(params[:trainer_id].to_i)
				Group.create :name => params[:name], :trainer_id => params[:trainer_id].to_i
			end
		end
		redirect_to group_index_path
	end

	def edit
		if params[:id]
			if Group.find_by_id params[:id]
				@group = Group.find_by_id params[:id]
			else
				redirect_to group_index_path
			end
		else
			redirect_to group_index_path
		end
	end

	def update
		if !params[:group_id]. blank? && !params[:name].blank? && !params[:trainer_id].blank?
			if Group.find_by_id params[:group_id]
				Group.find_by_id(params[:group_id]).update_attributes :trainer_id => params[:trainer_id].to_i, :name => params[:name]
			end
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
				end
			end
		end
		if Group.find_by_id(params[:group_id].to_i)
			redirect_to group_path params[:group_id]
		else
			redirect_to group_index_path
		end
	end

	def destroy

	end
end