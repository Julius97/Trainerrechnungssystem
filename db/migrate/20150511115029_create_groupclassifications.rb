class CreateGroupclassifications < ActiveRecord::Migration
  def change
    create_table :groupclassifications do |t|
      t.integer :group_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
