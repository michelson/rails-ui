# frozen_string_literal: true

class RailsUi::Accordion::Component < ApplicationViewComponent
  option :type, default: -> { "single" }
  option :collapsible, default: -> { true }

  renders_many :items, RailsUi::AccordionItem::Component
end
