Rails.application.routes.draw do
  mount CarrierWave::PostgresqlTable::RackApp.new => '/uploads'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  match '/set_current_locale', to: 'home#set_current_locale', via: 'get'
  resources :posts
  resources :pictures, only: %i[create destroy]
  resources :tags, only: [:show]
  resources :categories
end
