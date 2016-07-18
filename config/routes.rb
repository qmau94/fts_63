Rails.application.routes.draw do

  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"
  
  namespace :admin do
    root "static_pages#home"
    resources :subjects
    resources :users do
      collection {post :search, to: "users#index"}
    end
  end
  resources :exams, only: [:index, :create, :new]
  resources :subjects, only: :index
end
