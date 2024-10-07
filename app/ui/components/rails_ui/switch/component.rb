# frozen_string_literal: true

module RailsUi
  module Switch
    class Component < ApplicationViewComponent
      option :id
      option :url, default: -> { '' }
      option :label
      option :checked
      option :disabled
      option :on_change
    end
  end
end
