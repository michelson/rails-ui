# frozen_string_literal: true

class RailsUi::Avatar::Component < ApplicationViewComponent
  option :src, default: -> { nil }
  option :alt, default: -> {""}
  option :size, default: ->{:sm}

  def size_classes
    case size
    when :sm
      "h-8 w-8"
    when :lg
      "h-12 w-12"
    else # :md
      "h-10 w-10"
    end
  end

  def fallback_initials
    alt.split.map(&:first).join[0,2].upcase
  end
end
