class RenameTrainerIdinPricetoGroupId < ActiveRecord::Migration

  def change
  	rename_column :prices, :trainer_id, :group_id
  end

end
