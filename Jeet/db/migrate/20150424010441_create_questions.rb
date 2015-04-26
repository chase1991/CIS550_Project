class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :category
      t.string :range
      t.string :type
      t.timestamps null: false
    end
  end
end
