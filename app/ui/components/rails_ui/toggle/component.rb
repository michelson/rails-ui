# frozen_string_literal: true

module RailsUi
  module Toggle
    class Component < ApplicationViewComponent
      option :pressed, default: -> { false }
      option :variant, default: -> { :default }
      option :size, default: -> { :default }
      option :disabled, default: -> { false }
      option :aria_label, default: -> { nil }
      option :classes, default: -> { '' }

      renders_one :icon
      renders_one :text

      def base_classes
        'inline-flex items-center justify-center rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50'
      end

      def variant_classes
        case variant
        when :outline
          'border border-input bg-background hover:bg-accent hover:text-accent-foreground'
        else
          'bg-transparent hover:bg-muted hover:text-muted-foreground data-[state=on]:bg-accent data-[state=on]:text-accent-foreground'
        end
      end

      def size_classes
        case size
        when :sm
          'h-8 px-2'
        when :lg
          'h-12 px-4'
        else
          'h-10 px-3'
        end
      end

      def state
        pressed ? 'on' : 'off'
      end

      def stimulus_attributes
        {
          controller: 'ui-toggle',
          ui_toggle_pressed_value: pressed
        }
      end
    end
  end
end
