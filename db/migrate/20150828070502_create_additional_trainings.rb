class CreateAdditionalTrainings < ActiveRecord::Migration
  def change
    create_table :additional_trainings do |t|
      t.integer :training_id
      t.integer :customer_id
      t.datetime :training_start
      t.datetime :training_end
      t.integer :trainer_id
      t.integer :price_per_hour
      t.integer :discount_per_hour

      t.timestamps
    end
  end
end
