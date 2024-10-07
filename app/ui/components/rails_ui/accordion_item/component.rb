# frozen_string_literal: true

module RailsUi
  module AccordionItem
    class Component < ApplicationViewComponent
      option :value

      renders_one :trigger
    end
  end
end
