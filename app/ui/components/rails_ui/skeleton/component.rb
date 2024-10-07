# frozen_string_literal: true

module RailsUi
  module Skeleton
    class Component < ApplicationViewComponent
      option :variant, default: -> { :avatar }
      option :avatar_size, default: -> { 'h-12 w-12' }
      option :card_size, default: -> { 'h-[125px] w-[250px]' }
      option :lines, default: -> { 2 }
      option :line_widths, default: -> { %w[250px 200px] }
    end
  end
end
