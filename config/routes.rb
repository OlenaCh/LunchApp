Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users, only: [:index]
  resources :items, :orders, :menus
  resources :organizations, only: [:new, :create, :edit]
  
  get '/admins' => 'static_pages#admins_only', as: 'not_admins'
  root 'static_pages#index'
end