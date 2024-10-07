# frozen_string_literal: true

module RailsUi
  module Button
    class Preview < ApplicationViewComponentPreview
      # You can specify the container class for the default template
      # self.container_class = "w-1/2 border border-gray-300"
      layout 'rails_ui/preview'

      def default
        render(RailsUi::Button::Component.new { 'dfdfdf' })
      end

      def with_dynamic_title(title: 'Example component default')
        render(RailsUi::Button::Component.new { title })
      end
    end
  end
end
