Rails.application.routes.draw do

  resources :features
  resources :plans
  devise_for :users

  resources :subscriptions do
    post :subscribe
    delete :unsubscribe
    post :charge
  end

  resources :transactions
  resources :usages do
    get :add, on: :collection
    get :select_usage
  end

  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'

  root 'static_pages#home'
end
