Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"

  namespace :admin do
    root "exams#index"
    resources :subjects
    resources :users
    resources :questions, except: [:show]
    resources :exams, only: [:index, :edit, :update]
    mount Sidekiq::Web, at: "/sidekiq"
    resources :notifications, only: :index
    resources :suggest_questions, only: [:index, :show] do 
      resource :approve_questions, only: [:update]
    end
  end
  resources :exams, except: :destroy
  resources :subjects, only: :index
  resources :notifications, only: :index
  resources :suggest_questions, only: [:index, :new, :create]
end
