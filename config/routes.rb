Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'posts#index'
  resources :posts, only: [:index]
  resources :users, only: [:index, :show]
end
