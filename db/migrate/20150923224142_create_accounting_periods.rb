class CreateAccountingPeriods < ActiveRecord::Migration
  def change
    create_table :accounting_periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :accounting_group_id

      t.timestamps
    end
  end
end
