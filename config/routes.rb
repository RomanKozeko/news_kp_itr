Rails.application.routes.draw do

  resources :authors, only: [:index, :show]
  #resources :users
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :posts
  root to: "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
