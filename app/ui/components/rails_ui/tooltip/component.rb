# frozen_string_literal: true

module RailsUi
  module Tooltip
    class Component < ApplicationViewComponent
      option :placement, default: -> { 'top' }
      option :delay, default: -> { 700 }
      option :classes, default: -> { '' }

      renders_one :trigger

      def data_attributes
        {
          controller: 'ui-tooltip',
          ui_tooltip_placement_value: placement,
          ui_tooltip_delay_value: delay
        }
      end

      def data_attribute_string
        data_attributes.map { |key, value| "data-#{key.to_s.dasherize}=#{value}" }.join(' ')
      end
    end
  end
end
