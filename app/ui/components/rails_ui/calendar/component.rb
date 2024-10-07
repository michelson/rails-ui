# frozen_string_literal: true

require 'date'

module RailsUi
  module Calendar
    class Component < ApplicationViewComponent
      option :id, default: -> { SecureRandom.hex(6) }
      option :format, default: -> { 'PPPP' }
      option :view_date, default: -> { Date.today }
      option :selected_date, default: -> { nil }
      option :input_id, default: -> { 'formatted-date' }

      def weekdays
        %w[Mo Tu We Th Fr Sa Su]
      end
    end
  end
end
