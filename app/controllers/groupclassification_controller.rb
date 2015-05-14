class GroupclassificationController < ApplicationController

	before_action -> { check_session(true,false) }

	def destroy
		if params[:id]
			if Groupclassification.find_by_id params[:id]
				Groupclassification.find_by_id(params[:id]).destroy
			end
		end
		redirect_to group_index_path
	end

end