class ChangeNameTableRecipeStyles < ActiveRecord::Migration
  def change
  	rename_table :recipe_style, :recipe_styles
  end
end
