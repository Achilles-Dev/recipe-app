class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[create new]

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe: @recipe))
    respond_to do |format|
      format.html do
        if @recipe_food.save
          flash[:success] = 'Ingredient saved succesfully'
          redirect_to recipe_path(@recipe)
        else
          flash[:error] = 'Error: Ingredient could not be saved'
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.includes(:recipe).find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe), notice: 'Food Successfully deleted'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
