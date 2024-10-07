# frozen_string_literal: true

module RailsUi
  module Card
    class Component < ApplicationViewComponent
      option :title
      option :description
      option :footer, default: -> { nil }
    end
  end
end
