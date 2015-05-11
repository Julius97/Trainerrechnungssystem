class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.integer :groupclassification_id
      t.datetime :training_start
      t.datetime :training_end

      t.timestamps
    end
  end
end
