class RailsUi::ComponentPreview::Component < ViewComponent::Base
  renders_one :example
  renders_one :code

  attr_reader :title

  def initialize(title:)
    @title = title
  end

  def render_code
    ERB::Util.html_escape_once code
  end
end
