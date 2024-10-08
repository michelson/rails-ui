# app/components/rails_ui/alert_dialog/component.rb
module RailsUi
  module Dialog
    class Component < ApplicationViewComponent
      option :id, default: -> { SecureRandom.hex(6) }
      option :title
      option :description
      option :cancel_text, default: -> { "Cancel" }
      option :action_text, default: -> { "Action" }
      option :close_on_click_outside, default: -> { false }
      renders_one :trigger
    end
  end
end
