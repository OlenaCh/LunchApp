Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  resources :items, :orders, :menus
  
  root 'menus#index'
end