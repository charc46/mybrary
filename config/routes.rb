Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/search', to: 'books#new', as: 'search'
  get '/categories/:categories', to: 'pages#categories', as: 'categories'
  get '/author/:author', to: 'pages#author', as: 'author'
  get '/user_books/:id', to: 'user_books#mark_as_complete', as: 'complete_book'

  resources :books
  resources :user_books, only: [:update, :destroy]
end
