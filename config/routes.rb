RailsUi::Engine.routes.draw do


  root to: 'playground#index'

  get 'playground(/:section)', to: 'playground#show', as: :playground

end
