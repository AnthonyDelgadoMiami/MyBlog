
Rails.application.routes.draw do
  root 'posts#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: 'users#new'
  
  resources :users, except: [:destroy]
  resources :posts
  resources :relationships, only: [:create, :destroy]
  
  # Remove old location routes since we're focusing on posts
end
