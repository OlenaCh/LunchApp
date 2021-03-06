Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  resources :items, :orders, :menus
  
  get 'no_route' => 'errors#no_route'
  get 'record_not_found' => 'errors#record_not_found'
  get 'unauthorized' => 'errors#unauthorized'
  get 'users_only' => 'errors#users_only'
  
  root 'menus#index'
end