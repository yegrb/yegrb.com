Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get '/pages' => 'pages#index'
  get 'pages/meetup' => 'pages#meetup'
  get 'pages/contact' => 'pages#contact'
  get 'pages/about' => 'pages#about'
end