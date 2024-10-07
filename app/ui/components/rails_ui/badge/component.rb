# frozen_string_literal: true

module RailsUi
  module Badge
    class Component < ApplicationViewComponent
      option :variant, default: -> { :default }
      option :icon, default: -> { '' }

      def base_classes
        'inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2'
      end

      def variant_classes
        case variant
        when :default
          'border-transparent bg-primary text-primary-foreground hover:bg-primary/80'
        when :secondary
          'border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80'
        when :outline
          'text-foreground'
        when :destructive
          'border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80'
        else
          ''
        end
      end
    end
  end
end
