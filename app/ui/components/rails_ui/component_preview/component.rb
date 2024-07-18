class RailsUi::ComponentPreview::Component < ViewComponent::Base

  renders_one :example
  renders_one :code

  attr_reader :title

  def initialize(title:)
    @title = title
  end

  def call
    content_tag :div, class: "border rounded-lg overflow-hidden my-2" do
      concat(content_tag(:h3, title, class: "bg-gray-100 px-4 py-2 font-semibold"))
      concat(content_tag(:div, class: "flex flex-col md:flex-row") do
        concat(content_tag(:div, example, class: "preview flex min-h-[350px] w-full justify-center p-10 items-center border-b md:border-b-0 md:border-r"))
        concat(content_tag(:div, class: "w-full md:w-1/2 p-4") do
          content_tag(:pre, class: "language-erb") do
            content_tag(:code, code, class: "language-erb")
          end
        end)
      end)
    end
  end
end