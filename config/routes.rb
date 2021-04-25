require 'sidekiq/web'

Rails.application.routes.draw do
  resources :categories
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'

  namespace :madmin do
  end
end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]

  devise_for :users

  resources :users, only: [:show]
  resources :working_times
  resources :categories
  resources :grants, only: [:new, :create, :destroy]

  get 'start_timer', to: 'working_times#start_timer'
  get 'end_timer', to: 'working_times#end_timer'

  root to: 'home#index'
end
