# frozen_string_literal: true

class RailsUi::Breadcrumb::Component < ApplicationViewComponent
  renders_many :items, RailsUi::BreadcrumbItem::Component

  def separator
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-right"><path d="m9 18 6-6-6-6"></path></svg>'.html_safe
  end
end
