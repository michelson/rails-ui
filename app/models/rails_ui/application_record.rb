# frozen_string_literal: true

module RailsUi
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
