Rails.application.routes.draw do
  root 'users#index'
  # resources :users
  resources :locations

  resources :users do
    collection do
      delete 'destroy_multiple'
    end
  end

  resources :locations do
    collection do
      delete 'destroy_multiple'
    end
  end
  # get 'destory_multiple_locations', to: 'locations#destroy_multiple'
  # end

  # get '/locindex', to: 'locations#index'
  # get '/locindex/:id/edit', to: 'locations#edit', as: :edit_locindex

  #get 'new_user_path', to: 'users#new'
  # get '/users/:id', to: 'users#show'#, as: 'users'
  # get '/index', to: 'users#index'
  #get 'edit_delete', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
