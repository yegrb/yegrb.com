Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'pages#index'
  get '/meetup' , to: 'pages#meetup'
  get '/contact' , to: 'pages#contact'
  get '/about' , to: 'pages#about'
end