Rails.application.routes.draw do
  root 'time_punches#new'
  #get  '/help',    to: 'static_pages#help'
  #get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/', to: 'time_punches#new'
  post '/', to: 'time_punches#create'
  delete '/', to: 'time_punches#destroy'
  put '/', to: 'time_punches#index'
  patch '/', to: 'time_punches#edit'
  
  #dynamic form. access javascript controller
  match ':controller/:action.:format', via: [:get, :post]
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :time_punches
  resources :check_ins
  resources :selections
  resources :micro_fab_users
  
   
  
end