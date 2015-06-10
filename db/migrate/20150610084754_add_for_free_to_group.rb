class AddForFreeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :for_free, :boolean
  end
end
