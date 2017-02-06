Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations'
  }
  
  resources :users, only: [:index]
  resources :items, :orders, :menus
  
  get '/bills/show' => 'bills#show', as: bill
  
  root 'menus#index'
end