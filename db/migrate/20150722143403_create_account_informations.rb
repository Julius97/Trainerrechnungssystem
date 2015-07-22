class CreateAccountInformations < ActiveRecord::Migration
  def change
    create_table :account_informations do |t|
      t.integer :account_number, :limit => 9
      t.integer :bank_code, :limit => 8
      t.string :bic
      t.string :iban
      t.string :credit_institution

      t.timestamps
    end
  end
end
