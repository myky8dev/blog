class RecipeIngredient < ActiveRecord::Migration
  def change
  	  	create_table :recipe_ingredient do |t|
  		t.integer :ingredient_id, :recipe_id
  	end
  end
end
