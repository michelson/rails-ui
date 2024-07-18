# frozen_string_literal: true
class RailsUi::BreadcrumbItem::Component < ApplicationViewComponent

  option :href, default: -> {"#"}
  option :current, default: -> { false }

  def call
    if current
      content_tag(:span, content, role: "link", "aria-disabled": "true", "aria-current": "page", class: "font-normal text-foreground max-w-20 truncate md:max-w-none")
    else
      link_to(content, href, class: "transition-colors hover:text-foreground max-w-20 truncate md:max-w-none")
    end
  end
end