# app/components/rails_ui/alert_dialog/component.rb
module RailsUi
  module Chart
    class Component < ApplicationViewComponent
      #option :id, default: -> { SecureRandom.hex(6) }
      option :type, default: -> { 'line' }
      option :config, default: -> { {} }
      option :data, default: -> { {} }
      
    end
  end
end