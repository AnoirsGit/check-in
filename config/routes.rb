require 'sidekiq/web'

Rails.application.routes.draw do
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

  resources :users, only: [:show] do
    resources :working_times, shallow: true
  end

  root to: 'home#index'
end
