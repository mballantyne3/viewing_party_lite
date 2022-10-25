# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'landing#index'

  get '/register', to: 'users#new'
  get '/discover', to: 'users#discover'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/dashboard', to: 'users#show'
  post '/users', to: 'users#create'

  resources :users, only: %i[create] do
    resources :movies, only: %i[show index] do
      resources :parties, only: %i[new create]
    end
  end
end
