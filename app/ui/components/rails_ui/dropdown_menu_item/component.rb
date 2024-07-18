# frozen_string_literal: true

class RailsUi::DropdownMenuItem::Component < ApplicationViewComponent
  option :icon, optional: true
  option :shortcut, optional: true
  option :tag_name, default: -> { :a }
  option :html_options, default: -> { 
      {
        role: "menuitem",
        tabindex: "-1",
        class: "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground aria-selected:bg-accent aria-selected:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
      }
   }

  def callsss
    html_options[:class] = class_names(
      "group flex w-full items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      html_options[:class]
    )
    html_options[:role] ||= "menuitem"
    html_options[:tabindex] ||= "-1"

    super
  end
end