require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    def setup
        @chef = Chef.create(chefname: "bobasdasdd", email: "bosdddb@example.com")
        @recipe = @chef.recipes.build(name: "pollo test", summary: "esta es la mejor receta de pollo test.", description: "el horno a fuego lento, al poder ser con leña de sauce lloron para darle un toque a sal")
    end
    
    test "recipe should valid" do
        assert @recipe.valid? 
    end
    
    test "name should be present" do
        @recipe.name = " "
        assert_not @recipe.valid?
    end
    
    test "name length should not be too long" do
        @recipe.name = "a" * 101
        assert_not @recipe.valid?
    end
    
    test "name length should not be too short" do
        @recipe.name = "aaaa"
        assert_not @recipe.valid?
    end
    
    test "summary should be present" do
        @recipe.summary = " "
        assert_not @recipe.valid?
    end
    
    test "summary length should not be too long" do
        @recipe.summary = "a" * 151
        assert_not @recipe.valid?
    end
    
    test "summary length should not be too short" do
        @recipe.summary = "aaaaaaaaa"
        assert_not @recipe.valid?
    end
    
    test "description should be present" do
        @recipe.description = " "
        assert_not @recipe.valid?
    end
    
    test "description length should not be too long" do
        @recipe.description = "a" * 2001
        assert_not @recipe.valid?
    end
    
    test "description length should not be too short" do
        @recipe.description = "a" * 19
       assert_not @recipe.valid?
    end
    
    test "chef_id should be present" do
       @recipe.chef_id = nil
       assert_not @recipe.valid?
    end
end
