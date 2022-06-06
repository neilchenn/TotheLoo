Rails.application.routes.draw do
  devise_for :users
  root to: 'loos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :loos do
    resources :reviews, only: [:create]
    member do
      get :navigation
      post :favourite
      delete :unfavourite
    end
  end
end
