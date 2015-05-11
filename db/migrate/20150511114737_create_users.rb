class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :admin_permissions
      t.string :mail_address
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
