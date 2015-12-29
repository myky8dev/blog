class IngredientsController < ApplicationController
	before_action :require_user, except: [:show, :index]
	before_action :admin_user, only: [:destroy]

	def index
		@ingredients = Ingredient.paginate(page: params[:page], per_page: 4)
	end

	def new 
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)

	    if @ingredient.save
	      flash[:success] = "Your ingredient was created successfully!"
	      redirect_to ingredients_path
	    else
	      render :new
	    end
	end

	def show
		@ingredient = Ingredient.find(params[:id])
		@recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
	end

	def destroy
		ingredient = Ingredient.find(params[:id])
		if ! ingredient.recipes.any?
			ingredient.destroy
			flash[:success] = "Ingredient Deleted"
    	else
			flash[:danger] = "Ingredient can't be deleted"
		end
    	redirect_to ingredients_path
	end

	private 

    	def ingredient_params
      		params.require(:ingredient).permit(:name)
    	end

end