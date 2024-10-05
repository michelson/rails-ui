# frozen_string_literal: true

class RailsUi::Switch::Component < ApplicationViewComponent
  option :id
  option :url, default: -> { "" }
  option :label
  option :checked
  option :disabled
  option :on_change
end
