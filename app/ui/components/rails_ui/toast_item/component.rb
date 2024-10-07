# frozen_string_literal: true

module RailsUi
  module ToastItem
    class Component < ApplicationViewComponent
      option :title
      option :content
      option :type, default: -> { 'info' }

      def call
        content_tag :li,
                    class: toast_classes,
                    aria: { live: 'polite', atomic: true },
                    role: 'status',
                    tabindex: '0',
                    data: {
                      ui_toast_target: 'item',
                      action: 'click->ui-toast#dismiss'
                    } do
          content_tag :div, data: { content: '' } do
            content_tag(:div, title, data: { title: '' }) +
              content_tag(:div, content)
          end
        end
      end

      private

      def toast_classes
        'mb-2 p-4 rounded-md shadow-md transition-all duration-300 transform translate-y-full opacity-0'
      end
    end
  end
end
