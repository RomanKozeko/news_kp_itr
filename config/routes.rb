Rails.application.routes.draw do

  devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "callbacks" }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  root to: "posts#index"
  devise_for :users, skip: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :posts
  resources :pictures, only: [:create, :destroy]
  resources :tags, only: [:show]
  resources :categories
  resources :comments
  namespace :profile do
    resources :users, only: [:index, :edit, :update]
    patch "update_role/:id", to: "users#update_role", as: "update_role"
  end
  end

end
