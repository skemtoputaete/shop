Rails.application.routes.draw do

  #
  # => Маршруты для контроллера OrdersController
  #
  get 'orders/index'
  get 'orders/destroy'
  get 'orders/history', to: 'orders#history'
  get 'orders/buy/:id', to: 'orders#buy', as: "buy_orders"
  get 'orders/change_quantity/:position_id', to: 'orders#change_quantity', as: "change_quantity_orders"
  patch 'orders/change_quantity/:position_id', to: 'orders#update_quantity'
  get 'orders/update_quantity/', to: 'orders#update_quantity', as: "quantity_orders"
  get 'orders/update_quantity/:position_id(.:format)', to: 'orders#update_quantity', as: "update_quantity_orders"
  match 'orders/create/:id', to: 'orders#create', via: [:get, :post], as: "add_product_orders"
  delete 'orders/delete_product/:id/:product_id', to: 'orders#delete_product', as: "delete_product_orders"


  devise_for :users
  get 'main/index'

  resources :products
  resources :categories
  resources :administrator
  resources :orders

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
