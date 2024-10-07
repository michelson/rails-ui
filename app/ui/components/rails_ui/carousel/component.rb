# frozen_string_literal: true

module RailsUi
  module Carousel
    class Component < ApplicationViewComponent
      option :items, default: -> { [] }
    end
  end
end
