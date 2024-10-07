# frozen_string_literal: true

class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer

  private

  def identifier
    @identifier ||= self.class.name.sub('::Component', '').underscore.split('/').join('--')
  end

  def class_for(name, from: identifier)
    "c-#{from}-#{name}"
  end
end
