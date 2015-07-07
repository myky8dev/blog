class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :chefname, :email
    end
  end
end
