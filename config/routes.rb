Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :accountants, only: [:index, :show]
  resources :enquiries, only: [:new, :create, :show, :destroy, :update]
end
