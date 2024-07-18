# frozen_string_literal: true
module RailsUi
  module InputOtp
    class Component < ApplicationViewComponent
      option :groups, default: -> { [3, 3] }  # Default to two groups of 3
      option :separator, default: -> { true }
      option :input_mode, default: -> { "numeric" }
      option :pattern, default: -> { "^\\d+$" }
      option :autocomplete, default: -> { "one-time-code" }
      option :disabled, default: -> { false }

      def total_digits
        groups.sum
      end
    end
  end
end