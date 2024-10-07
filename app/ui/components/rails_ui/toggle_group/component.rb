# frozen_string_literal: true

module RailsUi
  module ToggleGroup
    class Component < ApplicationViewComponent
      renders_many :toggles
    end
  end
end
