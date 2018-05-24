Rails.application.routes.draw do
  patch "update_profile/:id", to: "users#update_profile", as: "update_profile"
  get "show_profile/:id", to: "users#show_profile", as: "show_profile"
  get "show_all", to: "users#show_all"
  resources :authors, only: [:index, :show, :edit, :update]
  #resources :users
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :posts
  root to: "posts#index"
  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [:show]
  resources :categories
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
