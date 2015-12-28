class RecipeStyle < ActiveRecord::Migration
  def change
  	create_table :recipe_style do |t|
  		t.integer :style_id, :recipe_id
  	end
  end
end
