# frozen_string_literal: true

module RailsUi
  module Progress
    class Component < ApplicationViewComponent
      option :value, default: -> { nil }
      option :max, default: -> { 100 }
      option :width, default: -> { '60%' }

      def indeterminate?
        value.nil?
      end

      def progress_style
        if indeterminate?
          'transform: translateX(-34%);'
        else
          "transform: translateX(-#{100 - (value.to_f / max * 100)}%);"
        end
      end
    end
  end
end
