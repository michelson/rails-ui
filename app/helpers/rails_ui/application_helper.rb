module RailsUi
  module ApplicationHelper
    def rails_ui_nav_items
      [
        {title: "Getting Started", type: "section"},
        {title: "Introduction", type: "link"},
        # { title: "Installation", type: "link"},
        # { title: "components.json", type: "link"},
        { title: "Theming", type: "link"},
        { title: "Dark mode", type: "link"},
        { title: "CLI", type: "link"},
        { title: "Typography", type: "link"},
        { title: "Figma", type: "link"},
        { title: "Changelog", type: "link"},
        { title: "Components", type: "section"},
        { title: "Accordion", type: "link"},
        { title: "Alert", type: "link"},
        { title: "Alert Dialog", type: "link"},
        { title: "Aspect Ratio", type: "link"},
        { title: "Avatar", type: "link"},
        { title: "Badge", type: "link"},
        { title: "Breadcrumb", type: "link"},
        { title: "Button", type: "link"},
        { title: "Calendar", type: "link"},
        { title: "Card", type: "link"},
        { title: "Carousel", type: "link"},
        { title: "Chart", type: "link"},
        { title: "Checkbox", type: "link"},
        { title: "Collapsible", type: "link"},
        { title: "Combobox", type: "link"},
        { title: "Command", type: "link"},
        { title: "Context Menu", type: "link"},
        { title: "Data Table", type: "link"},
        { title: "Date Picker", type: "link"},
        { title: "Dialog", type: "link"},
        { title: "Drawer", type: "link"},
        { title: "Dropdown-Menu", type: "link"},
        { title: "Form", type: "link"},
        { title: "Hover Card", type: "link"},
        { title: "Input", type: "link"},
        { title: "Input OTP", type: "link"},
        { title: "Label", type: "link"},
        { title: "Menubar", type: "link"},
        { title: "Navigation Menu", type: "link"},
        { title: "Pagination", type: "link"},
        { title: "Popover", type: "link"},
        { title: "Progress", type: "link"},
        { title: "Radio Group", type: "link"},
        { title: "Resizable", type: "link"},
        { title: "Scroll Area", type: "link"},
        { title: "Select", type: "link"},
        { title: "Simple Editor", type: "link"},
        { title: "Separator", type: "link"},
        { title: "Sheet", type: "link"},
        { title: "Skeleton", type: "link"},
        { title: "Slider", type: "link"},
        { title: "Sonner", type: "link"},
        { title: "Switch", type: "link"},
        { title: "Table", type: "link"},
        { title: "Tabs", type: "link"},
        { title: "Textarea", type: "link"},
        { title: "Toast", type: "link"},
        { title: "Toggle", type: "link"},
        { title: "Toggle Group", type: "link"},
        { title: "Tooltip",  type: "link"}
     ]
    end

    def next_section
      items = rails_ui_nav_items
      current_section = @section.parameterize.underscore
      current_index = items.find_index { |item| item[:title].parameterize.underscore == @section }
      return "#" unless current_index
    
      items[(current_index + 1)..].find { |item| item[:type] == "link" }[:title].parameterize.underscore
    end
    
    def prev_section
      items = rails_ui_nav_items
      current_section = @section.parameterize.underscore
      current_index = items.find_index { |item| item[:title].parameterize.underscore == @section }
      return "#" unless current_index
    
      items[0...current_index].reverse.find { |item| item[:type] == "link" }[:title].parameterize.underscore
    end
  end
end
