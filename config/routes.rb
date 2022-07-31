Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, except: [:update]
  resources :inventories, except: [:update] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end
  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  resources :shopping_lists, only: [:index, :create]
  get '/recipes/:recipe_id/generate_shopping_lists', to: 'shopping_lists#generate_shopping_lists', as: 'generate_shopping_lists'
  root "recipes#public_recipes"
end
