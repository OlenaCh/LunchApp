Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  resources :users, only: [:index]
  resources :items, :orders, :menus
  
  root 'menus#index'
end