Rails.application.routes.draw do
  get 'orders/index'

  get 'orders/destroy'

  post 'orders/create/:id', to: 'orders#create'

  devise_for :users
  get 'main/index'

  resources :products
  resources :categories
  resources :administrator
  resources :orders

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
