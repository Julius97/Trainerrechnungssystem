class ChangeColumnsFromAccountInformations < ActiveRecord::Migration
  def change
  	change_column :account_informations, :account_number, :string
  	change_column :account_informations, :bank_code, :string
  end
end
