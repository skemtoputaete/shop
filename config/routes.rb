Rails.application.routes.draw do

  #
  # => Маршруты для контроллера OrdersController
  #
  get 'orders/index'
  get 'orders/destroy'
  get 'orders/history', to: 'orders#history'
  get 'orders/buy/:id', to: 'orders#buy'
  get 'orders/change_quantity/:position_id', to: 'orders#change_quantity'
  patch 'orders/change_quantity/:position_id', to: 'orders#update_quantity'
  patch 'orders/update_quantity/:position_id(.:format)', to: 'orders#u1pdate_quantity'
  post 'orders/create/:id', to: 'orders#create'
  delete 'orders/delete_product/:id/:product_id', to: 'orders#delete_product'


  devise_for :users
  get 'main/index'

  resources :products
  resources :categories
  resources :administrator
  resources :orders

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
