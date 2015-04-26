class CreateFoodTypes < ActiveRecord::Migration
  def change
#  	drop_table :food_types
    create_table :food_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
