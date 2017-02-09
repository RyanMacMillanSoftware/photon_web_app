Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/microfab', to: 'time_punch#new'
  post '/microfab', to: 'time_punch#create'
  delete '/microfab', to: 'time_punch#destroy'
  put '/microfab', to: 'time_punch#index'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :timepunch, only: [:new, :create, :delete, :index, :edit, :update]
  
   
  
end