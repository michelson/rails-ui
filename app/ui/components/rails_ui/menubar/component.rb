# frozen_string_literal: true

# app/components/rails_ui/menubar/component.rb
module RailsUi
  module Menubar
    class Component < ApplicationViewComponent
      option :items, default: -> { [] }

      def submenu_content(items, parent_index = nil)
        content_tag(:div,
                    data: {
                      submenu_for: parent_index,
                      "ui-menubar-submenu": true
                    },
                    role: 'menu',
                    "aria-orientation": 'vertical',
                    class: 'hidden z-50 min-w-[12rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2') do
          safe_join(
            items.map.with_index do |item, index|
              item_index = parent_index ? "#{parent_index}-#{index}" : index.to_s
              if item == :separator
                content_tag(:div, '', role: 'separator', "aria-orientation": 'horizontal',
                                      class: '-mx-1 my-1 h-px bg-muted')
              else
                content_tag(:div,
                            role: 'menuitem',
                            data: {
                              "ui-menubar-submenu-item": item_index,
                              "has-submenu": item[:submenu] ? 'true' : 'false'
                            },
                            class: 'relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
                            tabindex: '-1',
                            "data-orientation": 'vertical') do
                  concat(item[:label])
                  if item[:shortcut]
                    concat(content_tag(:span, item[:shortcut],
                                       class: 'ml-auto text-xs tracking-widest text-muted-foreground'))
                  end
                  if item[:submenu]
                    concat(chevron_right_svg)
                    concat(submenu_content(item[:submenu], item_index))
                  end
                end
              end
            end
          )
        end
      end

      def chevron_down_svg
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-down ml-1 h-4 w-4"><polyline points="6 9 12 15 18 9"></polyline></svg>'.html_safe
      end

      def chevron_right_svg
        '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right ml-auto h-4 w-4"><polyline points="9 18 15 12 9 6"></polyline></svg>'.html_safe
      end
    end
  end
end
