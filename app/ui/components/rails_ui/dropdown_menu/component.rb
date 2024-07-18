# frozen_string_literal: true

module RailsUi
  module DropdownMenu
    class Component < ApplicationViewComponent
      renders_one :trigger
      renders_many :items, RailsUi::DropdownMenuItem::Component
      renders_many :separators #, SeparatorComponent
    end
  end
end