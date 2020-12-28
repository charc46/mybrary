Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/search', to: 'books#new', as: 'search'
  get '/categories/:categories', to: 'pages#categories', as: 'categories'
  get '/author/:author', to: 'pages#author', as: 'author'
  get '/user_books/:id', to: 'user_books#add_to_favourite', as: 'favourite_book'
  get '/favourites', to: 'pages#favourites', as: 'favourites'

  resources :books
  resources :user_books, only: [:update, :destroy]
end
