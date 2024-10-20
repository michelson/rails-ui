# frozen_string_literal: true

class RailsUi::Skeleton::Component < ApplicationViewComponent
  option :variant, default: -> { :avatar }
  option :avatar_size, default: -> { "h-12 w-12" }
  option :card_size, default: -> { "h-[125px] w-[250px]" }
  option :lines, default: -> { 2 }
  option :line_widths, default: -> { ["250px", "200px"] }
end
