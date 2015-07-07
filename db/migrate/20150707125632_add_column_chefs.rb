class AddColumnChefs < ActiveRecord::Migration
  def change
    change_table :chefs do |t|
      t.timestamps
    end
  end
end
