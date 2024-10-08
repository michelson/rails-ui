# frozen_string_literal: true

class RailsUi::Alert::Component < ApplicationViewComponent
  option :variant, default: -> { :default }
  option :icon, default: -> { "" }

  renders_one :title

  def variant_classes
    case variant
    when :destructive
      "border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive"
    else
      "bg-background text-foreground"
    end
  end

  def icon_svg
    case icon
    when :terminal
      '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-terminal h-4 w-4"><polyline points="4 17 10 11 4 5"></polyline><line x1="12" x2="20" y1="19" y2="19"></line></svg>'
    when :alert
      '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-alert h-4 w-4"><circle cx="12" cy="12" r="10"></circle><line x1="12" x2="12" y1="8" y2="12"></line><line x1="12" x2="12.01" y1="16" y2="16"></line></svg>'
    else
      ""
    end
  end
end
