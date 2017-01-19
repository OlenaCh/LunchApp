Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  resources :users, only: [:index]
  resources :items, :orders, :menus
  
  get '/admins' => 'static_pages#admins_only', as: 'not_admins'
  root 'static_pages#index'
end