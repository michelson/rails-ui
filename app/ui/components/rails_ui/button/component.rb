# frozen_string_literal: true

class RailsUi::Button::Component < ApplicationViewComponent
  option :variant, default: -> { :default }
  option :title, default: -> {}
  option :size, default: -> { :default }
  option :data, default: -> { {} }
  option :options, default: -> { {} }

  # include ViewComponent::Slotable
  renders_one :icon

  def button_attributes
    opts = {
      class: class_names(
        button_base_classes,
        variant_classes,
        size_classes
      ),
      **@options
    }

    opts.merge(data: stimulus_attributes)
  end

  def button_base_classes
    "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50"
  end

  def variant_classes
    case variant
    when :default
      "bg-primary text-primary-foreground hover:bg-primary/90"
    when :secondary
      "bg-secondary text-secondary-foreground hover:bg-secondary/80"
    when :outline
      "border border-input bg-background hover:bg-accent hover:text-accent-foreground"
    when :ghost
      "hover:bg-accent hover:text-accent-foreground"
    end
  end

  def size_classes
    case size
    when :default
      "h-10 px-4 py-2"
    when :sm
      "h-9 rounded-md px-3"
    when :lg
      "h-11 rounded-md px-8"
    when :icon
      "h-10 w-10"
    end
  end

  def stimulus_attributes
    {
      controller: "ui-button",
      action: "click->button#click"
    }.merge(data)
  end
end
