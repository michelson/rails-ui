# frozen_string_literal: true

module RailsUi
  module ContextMenu
    class Component < ApplicationViewComponent
      option :menu_items, default: -> { [] }
      option :side, default: -> { 'right' }
      option :align, default: -> { 'start' }
    end
  end
end
