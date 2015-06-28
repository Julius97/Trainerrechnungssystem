class CreateTrainingsplans < ActiveRecord::Migration
  def change
    create_table :trainingsplans do |t|
      t.integer :group_id
      t.integer :wday
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
