Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'pages#index'
  get '/meetup' , to: 'pages#meetup'
  get '/contact' , to: 'pages#contact'
  get '/about' , to: 'pages#about'
  get '/opportunities' , to: 'pages#opportunities'
  get '/slack' , to: 'pages#slack'
  get '/gs' , to: 'pages#gs'
  get '/learn_ror' , to: 'pages#learn_ror'
end