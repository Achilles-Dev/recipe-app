class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe = Recipe.includes(:foods).find(params[:recipe_id])
    redirect_to inventories_path if Inventory.first.nil?
    @inventory = Inventory.includes(:foods).find(params[:inventory_id])
    if @inventory.foods.first.nil?
      @all_foods = @recipe.foods.includes(:recipe_foods)
    else
      @all_foods = []
      @recipe.foods.each do |recipe_food|
        @all_foods.push(recipe_food) unless @inventory.foods.include?(recipe_food.name)
      end
    end
    @food_count = @all_foods.length
    @total_price = @all_foods.reduce(0) do |total, food|
      total + (food[:price] * food.recipe_foods.where(food:).pluck('quantity')[0])
    end
  end
end
