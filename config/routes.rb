Rails.application.routes.draw do
  resources :opportunities
  resources :events
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'pages#index'
  get '/contact' , to: 'pages#contact'
  get '/about' , to: 'pages#about'
end