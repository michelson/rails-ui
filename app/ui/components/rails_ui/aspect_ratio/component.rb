# frozen_string_literal: true

module RailsUi
  module AspectRatio
    class Component < ApplicationViewComponent
      option :ratio, default: -> { 16.0 / 9.0 }
      option :class_name, default: -> { "bg-muted" }
      option :image_src, default: -> { nil }
      option :image_alt, default: -> { nil }
      option :image_class, default: -> { "rounded-md object-cover" }

      def call
        content_tag :div, data: { "radix-aspect-ratio-wrapper": true }, style: wrapper_style do
          content_tag :div, class: class_name, style: "position: absolute; inset: 0px;" do
            if image_src
              image_tag image_src, alt: image_alt, class: image_class, style: image_style, loading: "lazy", decoding: "async"
            else
              content
            end
          end
        end
      end

      private

      def wrapper_style
        "position: relative; width: 100%; padding-bottom: #{(1 / ratio.to_f) * 100}%;"
      end

      def image_style
        "position: absolute; height: 100%; width: 100%; inset: 0px; color: transparent;"
      end
    end
  end
end