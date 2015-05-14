class AddParticipatedToTraining < ActiveRecord::Migration
  def change
    add_column :trainings, :participated, :boolean
  end
end
