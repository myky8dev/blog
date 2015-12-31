class RenameTableReviews < ActiveRecord::Migration
  def change
  	rename_table :table_reviews, :reviews
  end
end
