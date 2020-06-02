Rails.application.routes.draw do
  root "users#home"
  get "home/about" => "users#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:index, :edit, :update] do
    resource :relationships,  only: [:create, :destroy]
  end
  resources :books, only: [:create,:index,:show,:edit,:update,:destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
end
