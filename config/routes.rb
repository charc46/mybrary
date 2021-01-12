Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "my_devise/registrations" }
  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/search', to: 'books#new', as: 'search'
  get '/categories/:categories', to: 'pages#categories', as: 'categories'
  get '/author/:author', to: 'pages#author', as: 'author'
  get '/user_books/:id', to: 'user_books#add_to_favourite', as: 'favourite_book'
  get '/favourites', to: 'pages#favourites', as: 'favourites'
  get '/user_search', to: 'follows#index', as: 'search_user'
  post '/follow/:id', to: 'follows#create', as: 'follow_user'
  get '/profile/:id', to: 'pages#profile', as: 'profile'
  get '/users_books/:id', to: 'user_books#index', as: 'users_books'
  get '/users_book/:id', to: 'user_books#show', as: 'users_book'
  
  resources :books
  resources :user_books, only: [:create, :update, :destroy]
  resources :follows, only: [:index, :create, :destroy]
end
