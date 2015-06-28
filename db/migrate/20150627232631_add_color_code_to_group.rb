class AddColorCodeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :color_code, :string
  end
end
