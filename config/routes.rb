Rails.application.routes.draw do
  
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users, only: [:index]
  resources :items, :orders
  resources :organizations, only: [:new, :create, :edit]
  get '/today' => 'orders#today_index', as: 'today_orders'
  
  get '/admins' => 'static_pages#admins_only', as: 'not_admins'
  get '/users' => 'static_pages#users_only', as: 'not_users'
  root 'static_pages#index'
  
end