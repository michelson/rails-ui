# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#show'

  mount RailsUi::Engine => '/rails_ui'
end
