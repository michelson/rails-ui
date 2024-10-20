# frozen_string_literal: true

class RailsUi::Collapsible::Component < ApplicationViewComponent
  option :open, default: -> { false }
  # option :class, default: -> { "" }
  option :content_class, default: -> { "" }

  renders_one :trigger
  renders_one :header
  renders_many :items
  renders_one :collapsible_content

  def stimulus_attributes
    {
      controller: "ui-collapsible",
      ui_collapsible_open_value: open
    }
  end

  def data_attributes
    stimulus_attributes.map { |k, v| "data-#{k.to_s.dasherize}=#{v}" }.join(" ")
  end
end
