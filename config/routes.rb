Rails.application.routes.draw do
  get 'sessions/new'
  root'static_pages#home'
  get '/signup', to: 'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/newpost', to: 'microposts#new'
  resources :microposts, only: [:index, :new, :create, :destroy]
end
