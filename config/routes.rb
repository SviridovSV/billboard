Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, only: [:index]
  resources :users, only: [:index, :show]
end
