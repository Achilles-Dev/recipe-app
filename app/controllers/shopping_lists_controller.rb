class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inventory
  before_action :set_recipe
  before_action :set_all_foods

  def index
    redirect_to inventories_path if Inventory.first.nil?
    @food_count = @all_foods.count
    @total_price = @all_foods.reduce(0) do |total, food|
      total + (food.price * food.recipe_foods.where(food:).pluck('quantity')[0])
    end
  end

  private

  def set_inventory
    @inventory = Inventory.includes(:foods).find(params[:inventory_id])
  end

  def set_recipe
    @recipe = Recipe.includes(:foods).find(params[:recipe_id])
  end

  def set_all_foods
    if @inventory.foods.first.nil?
      @all_foods = @recipe.foods.includes(:recipe_foods)
    else
      @all_foods = []
      @recipe.foods.each do |recipe_food|
        food = Food.find(recipe_food.id)
        if @inventory.foods.include?(food)
          inventory = @inventory.inventory_foods.find_by(food_id: recipe_food.id)
          recipe = @recipe.recipe_foods.find_by(food_id: recipe_food.id)
          if inventory.quantity < recipe.quantity
            recipe_food.attributes.each_with_object(recipe_food) do |_name, object|
              object.price = ((recipe.quantity - inventory.quantity) * food.price) / recipe.quantity
            end
            @all_foods.push(recipe_food)
          end
        else
          @all_foods.push(recipe_food)
        end
      end
    end
  end
end
