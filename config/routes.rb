Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/search', to: 'books#new', as: 'search'
  get '/categories/:categories', to: 'pages#categories', as: 'categories'
  get '/author/:author', to: 'pages#author', as: 'author'

  resources :books
  resources :user_books, only: :update
end
