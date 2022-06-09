Rails.application.routes.draw do
  devise_for :users
  root to: 'loos#index'
  resources :loos do
    resources :reviews, only: [:create, :new]
    member do
      get :navigation
      post :favourite
      delete :unfavourite
    end
    collection do
      get :nearest_loo
    end
  end
end
