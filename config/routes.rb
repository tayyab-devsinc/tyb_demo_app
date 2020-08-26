Rails.application.routes.draw do

  devise_for :users

  resources :features

  resources :plans

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'

  root 'static_pages#home'
end
