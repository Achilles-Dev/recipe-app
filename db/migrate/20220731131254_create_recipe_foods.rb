class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.decimal :quantity
      t.timestamps
      t.integer :recipe_id
      t.integer :food_id
    end
    add_index :recipe_foods, :recipe_id
    add_index :recipe_foods, :food_id
    add_foreign_key :recipe_foods, :recipes
    add_foreign_key :recipe_foods, :foods
  end
end
