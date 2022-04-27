require 'sidekiq/web'

Rails.application.routes.draw do
  resources :projects do
    resources :tasks, except: [:index] do
      member do
        post :add_user
        post :start_timer
        post :end_timer
      end
    end
    member do
      post :add_user
    end
  end
  resources :tweets
  namespace :posts do
    resource :bulk, controller: :bulk do
      collection do
        post 'publish'
        post 'delete'
      end
    end
  end
  resources :posts
  resources :blog_posts
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'

  namespace :madmin do
  end
end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users
  root to: 'projects#index'

  get 'calendar', to: 'home#calendar'
  get 'rooms/:id', to: 'rooms#show'

  resources :tweets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
