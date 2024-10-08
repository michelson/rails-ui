# frozen_string_literal: true

module RailsUi
  module Resizable
    class Component < ApplicationViewComponent
      option :id, default: -> { SecureRandom.hex(6) }
      option :direction, default: -> { "horizontal" }
      option :panels, default: -> { [] }
      option :class_name, default: -> { "min-h-[200px] rounded-lg border" }
    end
  end
end
