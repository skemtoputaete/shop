Rails.application.routes.draw do

  #
  # => Маршруты для контроллера OrdersController
  #
  get 'orders/index'
  get 'orders/destroy'
  get 'orders/history', to: 'orders#history'
  post 'orders/create/:id', to: 'orders#create'
  delete 'orders/delete_product/:id/:product_id', to: 'orders#delete_product'
  get 'orders/buy/:id', to: 'orders#buy'

  devise_for :users
  get 'main/index'

  resources :products
  resources :categories
  resources :administrator
  resources :orders

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
