class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipes]
  before_action :set_user

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
    @recipe = Recipe.includes(:user, recipe_foods: %i[food recipe]).find(params[:id])
    @inventories = Inventory.all
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:success] = 'Recipe successfully deleted'
    redirect_to recipes_path
  end

  def public_recipes
    @public_recipes = Recipe.includes(:user, :foods, :recipe_foods).where(public: true).order('created_at DESC')
  end

  private

  def recipe_params
    params.require('recipe').permit(:name, :description, :cooking_time, :preparation_time, :public)
  end

  def set_user
    @user = current_user
  end
end
