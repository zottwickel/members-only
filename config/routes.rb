Rails.application.routes.draw do
  ######## Static Pages #########
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/contact', to: 'static_pages#contact'
  ######## Sessions ########
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  ######## Users #########
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  
  resources :posts, only: [:new, :create, :index, :show]
  resources :users
end
