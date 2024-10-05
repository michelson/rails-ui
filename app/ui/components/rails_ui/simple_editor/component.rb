# frozen_string_literal: true

class RailsUi::SimpleEditor::Component < ApplicationViewComponent
  option :preview_id, default: -> { nil }
  option :variables, default: -> { {} }
  option :height, default: -> { "h-20" }
  option :data
  option :form
  option :field
end