# frozen_string_literal: true

class RailsUi::Separator::Component < ApplicationViewComponent
  # Available orientations for the separator
  ORIENTATIONS = %w[horizontal vertical].freeze

  # Define initializer to accept orientation and class_name as parameters
  def initialize(orientation: "horizontal", class_name: "")
    @orientation = ORIENTATIONS.include?(orientation) ? orientation : "horizontal"
    @class_name = class_name
  end

  # Provides the CSS class for the separator
  def separator_class
    base_class = "shrink-0 bg-border"
    orientation_class = @orientation == "vertical" ? "h-full w-[1px]" : "h-[1px] w-full my-4"
    [base_class, orientation_class, @class_name].compact.join(" ")
  end
end

