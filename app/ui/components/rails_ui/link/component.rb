# frozen_string_literal: true

class RailsUi::Link::Component < RailsUi::Button::Component
  option :action, default: -> { "#" }

end
