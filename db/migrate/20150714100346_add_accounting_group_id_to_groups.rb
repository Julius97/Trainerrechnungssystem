class AddAccountingGroupIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :accounting_group_id, :integer
  end
end
