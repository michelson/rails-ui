# frozen_string_literal: true

# app/components/rails_ui/command/component.rb
module RailsUi
  module Command
    class Component < ApplicationViewComponent
      option :id, default: -> { SecureRandom.hex(6) }
      option :placeholder, default: -> { "Type a command or search..." }
      option :sections, default: -> { [] }
    end
  end
end
