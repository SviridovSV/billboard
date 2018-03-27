Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'posts#index'
  resources :posts do
    # collection do
    #   get :search
    # end
    resources :comments
  end
  resources :users, only: [:index, :show]
end
