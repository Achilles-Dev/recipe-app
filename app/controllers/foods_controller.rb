class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index create]

  def index
    @foods = @user.foods
  end

  def new
    @food = Food.new
  end

  def create
    food = Food.new(food_params.merge(user: @user))
    respond_to do |format|
      format.html do
        if food.save
          flash[:success] = 'Food created successfully'
          redirect_to foods_path
        else
          flash.now[:error] = 'Error: Food could not be created'
          render :new
        end
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
    flash[:success] = 'Food was deleted!'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end

  def set_user
    @user = current_user
  end
end
