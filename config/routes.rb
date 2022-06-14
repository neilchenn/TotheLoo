Rails.application.routes.draw do
  devise_for :users
  root to: 'loos#index'
  resources :loos do
    resources :reviews, only: [:create, :new]
    resources :loos, only: [:new, :create]
    member do
      get :navigation
      post :favourite
      delete :unfavourite
    end
    collection do
      get :nearest_loo
    end
  end
  get '/my_favorites', to: 'dashboard#my_favorites', as: :my_favorites
end
