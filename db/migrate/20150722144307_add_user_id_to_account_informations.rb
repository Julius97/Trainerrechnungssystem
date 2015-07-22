class AddUserIdToAccountInformations < ActiveRecord::Migration
  def change
    add_column :account_informations, :user_id, :integer
  end
end
