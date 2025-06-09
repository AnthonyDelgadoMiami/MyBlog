Rails.application.routes.draw do
  root 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  resources :users do
    delete 'destroy_multiple', on: :collection
    member do
      get 'following'
      get 'followers'
      delete 'unfollow_user', to: 'relationships#destroy'
      post 'follow_user', to: 'relationships#create'
    end
  end
  resources :posts
  resources :relationships, only: %i[create destroy]

  # Remove old location routes since we're focusing on posts
end
