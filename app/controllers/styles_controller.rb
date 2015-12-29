class StylesController < ApplicationController
	before_action :require_user, except: [:show, :index]
	before_action :admin_user, only: [:destroy]
	
	def index
		@styles = Style.paginate(page: params[:page], per_page: 4)
	end

	def new 
		@style = Style.new
	end

	def create
		@style = Style.new(style_params)

	    if @style.save
	      flash[:success] = "Your style was created successfully!"
	      redirect_to styles_path
	    else
	      render :new
	    end
	end

	def show
		@style = Style.find(params[:id])
		@recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
	end

	def destroy
		style = Style.find(params[:id])
		if ! style.recipes.any?
			style.destroy
			flash[:success] = "Style Deleted"
		else
			flash[:danger] = "Style can't be deleted"
		end
    	redirect_to styles_path
	end

	private 

    	def style_params
      		params.require(:style).permit(:name)
    	end
end