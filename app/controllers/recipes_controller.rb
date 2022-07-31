class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipes]
  before_action do
    @user = current_user
    @foods = RecipeFood.find_by(recipe: @recipe)
  end

  def index
    @recipes = @user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(recipe_params.merge(user: @user))
    respond_to do |format|
      format.html do
        if recipe.save
          flash[:success] = 'New Recipe created'
          redirect_to recipes_path
        else
          flash.now[:error] = 'Error: Recipe could not be created'
          render :new
        end
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:success] = 'Recipe successfully deleted'
    redirect_to recipes_path
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order('created_at DESC')
  end

  private

  def recipe_params
    params.require('recipe').permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end
