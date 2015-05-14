class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :price_per_lesson
      t.integer :discount_per_lesson
      t.integer :trainer_id

      t.timestamps
    end
  end
end
