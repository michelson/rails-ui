# frozen_string_literal: true

# app/components/rails_ui/popover/component.rb
#

# Remember to style the arrow appropriately in your CSS.
# You might want to add something like this to your stylesheet:
# cssCopy[data-ui-popover-target="arrow"] {
#   position: absolute;
#   background: inherit;
#   width: 8px;
#   height: 8px;
#   transform: rotate(45deg);
# }
#
module RailsUi
  module Popover
    class Component < ApplicationViewComponent
      renders_one :trigger

      option :id, default: -> { SecureRandom.hex(6) }
      option :placement, default: -> { "bottom" }
      option :offset, default: -> { 6 }
      option :arrow, default: -> { false }
      option :trigger_type, default: -> { "click" }
    end
  end
end
