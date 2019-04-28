Rails.application.routes.draw do
  mount CarrierWave::PostgresqlTable::RackApp.new => '/uploads'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
end
