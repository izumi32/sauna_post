Rails.application.routes.draw do
  get 'sessions/new'
  root'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/newpost', to: 'microposts#new'
  resources :users do
    member do
      get :following, :followers
      # => users/:id/following following_user_path(:id)
      # => users/:id/followers followers_user_path(:id)
    end
  end
  resources :microposts, only: [:index, :new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
