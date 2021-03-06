Rails.application.routes.draw do
  get 'testapi/index'
  get 'testapi/show(.:format)', to: 'testapi#show', as: 'testapi_show'
  get 'testapi/products(.:format)', to: 'testapi#products', as: 'testapi_products'
  get 'testapi/description(.:format)', to: 'testapi#description', as: 'testapi_description'

  get 'search/search'
  get 'search/search_autocomplete'

  get 'chat_support/write', to: 'chat_support#write'
  get 'chat_support/:id', to: 'chat_support#show', as: 'show_chat'
  get 'chat_support/', to: 'chat_support#index'
  #
  # => Маршруты для контроллера OrdersController
  #
  get 'orders/index'
  get 'orders/destroy'
  get 'orders/history', to: 'orders#history'
  get 'orders/buy/:id', to: 'orders#buy', as: 'buy_orders'
  get 'orders/change_quantity/:position_id', to: 'orders#change_quantity', as: 'change_quantity_orders'
  patch 'orders/change_quantity/:position_id', to: 'orders#update_quantity', as: 'patch_quantity_orders'
  get 'orders/update_quantity/', to: 'orders#update_quantity', as: 'quantity_orders'
  get 'orders/update_quantity/:position_id(.:format)', to: 'orders#update_quantity', as: 'update_quantity_orders'
  match 'orders/create/:id', to: 'orders#create', via: %i[get post], as: 'add_product_orders'
  delete 'orders/delete_product/:id/:product_id', to: 'orders#delete_product', as: 'delete_product_orders'
  get 'orders/delete_product/:id/:product_id', to: 'orders#delete_product', as: 'get_delete_product_orders'

  devise_for :users
  get 'main/index'

  resources :products
  resources :categories
  resources :administrator
  resources :orders
  resources :testapi

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
