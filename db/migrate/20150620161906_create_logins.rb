class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.boolean :mobile_device

      t.timestamps
    end
  end
end
