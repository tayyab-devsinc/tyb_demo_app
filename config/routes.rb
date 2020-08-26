Rails.application.routes.draw do

  resources :features
  resources :plans
  devise_for :users

  resources :subscriptions do
    post :subscribe
    delete :unsubscribe
  end

  resources :transactions
  resources :usages

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'

  root 'static_pages#home'
end
