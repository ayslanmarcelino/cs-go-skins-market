Rails.application.routes.draw do
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  root "enterprises#select"
  devise_for :users

  get 'dashboard/index'
  get 'report', to: 'dashboard#pdf'

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

  resources :clients, only: [:index, :new, :create]

  namespace :steam do
    resources :accounts, only: [:index, :new, :create, :update, :destroy] do
      member do
        patch :disable
        patch :enable
      end
    end
  end
end
