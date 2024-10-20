# frozen_string_literal: true

class RailsUi::Card::Component < ApplicationViewComponent
  option :title
  option :description
  option :footer, default: -> {}
end
