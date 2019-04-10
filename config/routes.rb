Rails.application.routes.draw do
  resources :videos
  resources :invites, except: %i[edit update show]
  resources :opportunities do
    post 'close', on: :member
  end
  resources :events

  # users
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  # static pages
  root 'pages#index'
  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'
  get '/opportunities', to: 'pages#opportunities'
  get '/slack', to: 'pages#slack'
  get '/resources', to: 'pages#resources'

  get '/check.txt', to: proc { [200, {}, ['it_works']] }
end
