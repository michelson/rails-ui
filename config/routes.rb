RailsUi::Engine.routes.draw do
  root to: 'playground#index'
  get 'playground(/:section)', to: 'playground#show', as: :playground
  resources :blocks    
  resources :charts    
  resources :themes    
  resources :examples    
  resources :colors
end
