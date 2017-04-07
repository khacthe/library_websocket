Rails.application.routes.draw do

  root "static_pages#home"

  get "/login", to: "sessions#new"
  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: [:destroy]
  resources :books, only: [:index, :show]
  resources :authors, only: [:index, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets, except: [:index, :show, :destroy]
  resources :follow_users, only: [:create, :destroy]
  resources :follow_books, only: [:create, :destroy]
  resources :follow_authors, only: [:create, :destroy]
  resources :like_actives, only: [:create, :destroy]
  resources :borrow_books

  namespace :admin do
    resources :users
    resources :categories
    resources :authors
    resources :publishers
    resources :books
    resources :borrow_books
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :books do
    member do
      get :following_book, :followers_book
      get :liking_book, :likewers_book
    end
    resources :commments
  end

  resources :author do
    member do
      get :following_author, :followers_author
    end
  end
end
