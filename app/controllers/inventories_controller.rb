class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[index create]

  def index
    @inventories = @user.inventories
  end

  def new
    @inventory = Inventory.new
  end

  def create
    inventory = Inventory.new(inventory_params.merge(user: @user))
    respond_to do |format|
      format.html do
        if inventory.save
          flash[:success] = 'New inventory created'
          redirect_to inventories_path
        else
          flash.now[:error] = 'Error: Inventory could not be created'
          render :new
        end
      end
    end
  end

  def show
    @inventory = Inventory.includes(inventory_foods: [:food]).find(params[:id])
  end

  def destroy
    inventory = Inventory.find(params[:id])
    inventory.destroy
    flash[:success] = 'Inventory successfully deleted'
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require('inventory').permit(:name)
  end

  def set_user
    @user = current_user
  end
end
