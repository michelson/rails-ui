# frozen_string_literal: true

class RailsUi::ContextMenu::Component < ApplicationViewComponent
  option :menu_items, default: -> { [] }
  option :side, default: -> { "right" }
  option :align, default: -> { "start" }

end