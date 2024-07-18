# frozen_string_literal: true

class RailsUi::Carousel::Component < ApplicationViewComponent
  option :items, default: -> { [] }
end
