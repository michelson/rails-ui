# frozen_string_literal: true

class RailsUi::Sheet::Component < ApplicationViewComponent
  option :side, default: -> { :right }
  option :size, default: -> { :default }

  renders_one :trigger

  def side_classes
    case side
    when :top
      "inset-x-0 top-0 border-b w-full"
    when :right
      "inset-y-0 right-0 h-full border-l #{width_classes}"
    when :bottom
      "inset-x-0 bottom-0 border-t w-full"
    when :left
      "inset-y-0 left-0 h-full border-r #{width_classes}"
    end
  end

  def width_classes
    case size
    when :sm
      "w-3/4 sm:max-w-sm"
    when :lg
      "w-3/4 sm:max-w-lg"
    when :xl
      "w-3/4 sm:max-w-xl"
    when :full
      "w-screen"
    else # default
      "w-3/4 sm:max-w-md"
    end
  end

  def height_classes
    return "" unless [:top, :bottom].include?(side)

    case size
    when :sm
      "h-1/4"
    when :lg
      "h-1/2"
    when :xl
      "h-3/4"
    when :full
      "h-screen"
    else # default
      "h-1/3"
    end
  end

  def transition_classes
    "transition-all duration-300"
  end
end