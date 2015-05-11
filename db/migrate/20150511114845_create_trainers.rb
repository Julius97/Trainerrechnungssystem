class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
