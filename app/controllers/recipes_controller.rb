class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like, :add_review, :edit_review, :update_review, :destroy_review]
  before_action :set_reviews, only: [:show, :add_review, :edit_review]
  before_action :require_user, except: [:show, :index, :like, :add_review]
  before_action :require_user_like, only: [:like]
  before_action :require_user_review, only: [:add_review]
  before_action :require_same_user, only: [:edit, :update, :edit_review, :update_review]
  before_action :admin_user, only: [:destroy, :destroy_review]

  def index
    #@recipes = Recipe.all.sort_by {|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end
    
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save
      flash[:success] = "Your recipe was created successfully!"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated succesfully!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def show
    #binding.pry #Para hacer test de parametros de un form a otro
    if @review == nil
      @review = @new_review
    end
  end

  def add_review
    @review = Review.create(comment: params[:review][:comment], chef: current_user, recipe: @recipe)
    #binding.pry
    if @review.valid?
      flash[:success] = "Your comment was created successfull"
      redirect_to recipe_path(@recipe)
    else
      #flash[:danger] = "That comment not are valid"
      render :show
    end
  end

  def edit_review
    @review = Review.find(params[:format])
    render :show
  end

  def update_review
    review = Review.find(params[:format])
    if review.valid? 
      if review.comment != params[:review][:comment]
        review.comment = params[:review][:comment]
        review.save
        flash[:success] = "Your comment was updated successfull"
        redirect_to recipe_path(@recipe)
      else
        flash[:warning] = "The comment are the same"
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  def destroy_review
    Review.find(params[:format]).destroy
    flash[:success] = "Comment deleted"
    redirect_to recipe_path(@recipe)
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe Deleted"
    redirect_to recipes_path
  end
  
  private 

    $page = nil

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_reviews
      @new_review = Review.new
      @new_review.recipe = @recipe
      if params[:page] != nil
        $page = params[:page]
      end
      @reviews = @recipe.reviews.paginate(page: $page, per_page: 4).order('updated_at DESC')
      if ! @reviews.any?
        $page = $page.to_i - 1
        @reviews = @recipe.reviews.paginate(page: $page, per_page: 4).order('updated_at DESC')
      end
    end

    def require_same_user
      if current_user != @recipe.chef and ! current_user.admin?
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
      end
    end

    def require_user_like
      if ! logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to :back
      end
    end

    def require_user_review
      if ! logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to register_path
      end
    end
end
