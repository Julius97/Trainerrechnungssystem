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
				redirect_to customer_index_path
			end
		else
			redirect_to customer_index_path
		end
	end

	def new

	end

	def create
		if !params[:first_name].blank? && !params[:last_name].blank?
			if Customer.where(:first_name => params[:first_name], :last_name => params[:last_name]).count == 0
				Customer.create :first_name => params[:first_name], :last_name => params[:last_name]
			end
		end
		redirect_to customer_index_path
	end

	def edit
		if params[:id]
			if Customer.find_by_id params[:id]
				@customer = Customer.find_by_id params[:id]
			else
				redirect_to customer_index_path
			end
		else
			redirect_to customer_index_path
		end
	end

	def update
		if !params[:first_name].blank? && !params[:last_name].blank? && params[:customer_id]
			if Customer.where(:first_name => params[:first_name], :last_name => params[:last_name]).count == 0
				if Customer.find_by_id params[:customer_id]
					Customer.find_by_id(params[:customer_id]).update_attributes :first_name => params[:first_name], :last_name => params[:last_name]
				end
			end
		end
		redirect_to customer_index_path
	end

	def destroy
		if params[:id]
			if Customer.find_by_id params[:id]
				Customer.find_by_id(params[:id]).destroy
				redirect_to customer_index_path
			else
				redirect_to customer_index_path
			end
		else
			redirect_to customer_index_path
		end
	end

end