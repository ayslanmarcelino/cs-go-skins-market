Rails.application.routes.draw do
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  root "enterprises#select"
  devise_for :users

  get 'dashboard/index'
  get 'report', to: 'dashboard#pdf'

  require 'sidekiq/web'

  authenticate :user, ->(user) { user.roles.any? { |role| role.kind == :admin_master } } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :profiles, only: :select

  resources :enterprises, only: [:index, :show, :new, :create, :edit, :update, :select] do
    member do
      patch :activate
      patch :disable
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        patch :disable
        patch :activate
        patch :update_current_enterprise
      end
    end
  end

  namespace :user do
    resources :roles, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  namespace :steam do
    resources :accounts, only: [:index, :new, :create, :update, :destroy] do
      member do
        patch :disable
        patch :enable
      end
    end
  end

  resources :skins, only: [:index, :show, :edit, :update] do
    collection do
      post 'search'
      post 'update_prices'
      get 'available'
    end

    member do
      patch :disable
      patch :enable
    end
  end

  resources :transactions, only: [:index, :new, :create, :edit, :update] do
    member do
      patch :cancel
      patch :finish
    end
  end

  namespace :transaction do
    resources :types, only: [:new, :create]
  end
end
