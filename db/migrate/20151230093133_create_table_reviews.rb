class CreateTableReviews < ActiveRecord::Migration
  def change
    create_table :table_reviews do |t|
    	t.integer :chef_id, :recipe_id
    	t.text :comment
    	t.timestamps
    end
  end
end
