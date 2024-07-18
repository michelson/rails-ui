# app/components/rails_ui/alert_dialog/component.rb
module RailsUi
  module Dialog
    class Component < ApplicationViewComponent
      option :id, default: -> { SecureRandom.hex(6) }
      option :title
      option :description
      option :close_on_click_outside, default: -> { false }
      renders_one :trigger
    end
  end
end