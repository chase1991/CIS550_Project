class CreateFoodClasses < ActiveRecord::Migration
  def change
  	drop_table :food_classes
    create_table :food_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
