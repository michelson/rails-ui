# frozen_string_literal: true

# app/components/rails_ui/toast/component.rb
module RailsUi
  module Toast
    class Component < ApplicationViewComponent
      renders_many :toast_items, ToastItem::Component

      def call
        content_tag :section,
          aria: {label: "Notifications (alt+T)"},
          tabindex: "-1",
          data: {
            controller: "ui-toast",
            ui_toast_theme_value: "light",
            ui_toast_position_y_value: "bottom",
            ui_toast_position_x_value: "right"
          } do
          content_tag :ol,
            dir: "ltr",
            tabindex: "-1",
            data: {
              ui_toast_target: "container",
              sonner_toaster: true
            },
            style: toast_container_style do
            toast_items
          end
        end
      end

      private

      def toast_container_style
        "--front-toast-height: 0px; --offset: 32px; --width: 356px; --gap: 14px;"
      end
    end
  end
end
