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
  
  resources :books
  resources :user_books, only: [:update, :destroy]
  resources :follows, only: [:index, :create, :destroy]
end
