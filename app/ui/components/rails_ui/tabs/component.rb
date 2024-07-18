# frozen_string_literal: true

class RailsUi::Tabs::Component < ApplicationViewComponent
  option :items
  option :variant, default: -> { :buttons }
  option :orientation, default: -> { :horizontal }
  option :turbo_frame, default: -> { nil }
  
  def tab_list_classes
    if variant == :buttons
      "h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground grid w-full grid-cols-#{items.size}"
    else
      "scrollable overflow-auto"
    end
  end

  def tab_classes(item)
    base_classes = "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"
    
    if variant == :buttons
      active_classes = "data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow-sm"
    else
      active_classes = item[:active] ? "active border-indigo-500 text-indigo-600 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm" : "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm"
    end

    "#{base_classes} #{active_classes}"
  end
end