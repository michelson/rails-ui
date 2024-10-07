# frozen_string_literal: true

module RailsUi
  module Accordion
    class Component < ApplicationViewComponent
      option :type, default: -> { 'single' }
      option :collapsible, default: -> { true }

      renders_many :items, RailsUi::AccordionItem::Component
    end
  end
end
