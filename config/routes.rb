Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root 'pages#index'
  get '/pages' , to: 'pages#index'
  get 'pages/meetup' , to: 'pages#meetup'
  get 'pages/contact' , to: 'pages#contact'
  get 'pages/about' , to: 'pages#about'
end