# frozen_string_literal: true

class RailsUi::AccordionItem::Component < ApplicationViewComponent
  option :value

  renders_one :trigger
end
