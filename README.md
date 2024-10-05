# RailsUi

RailsUi is a collection of UI components for Rails, heavily inspired by [shadcn-ui/ui](https://github.com/shadcn-ui/ui) but specifically built for Rails using ERB templates and ViewComponents.

## Why ERB?

We chose ViewComponents because they embrace ERB, which aligns with the traditional Rails approach and offers a familiar, straightforward syntax while providing a way to structure atomized and testable components. While other alternatives like the great Phlex library or even raw helper are great, we opted for ViewComponents as we can have a higher level to maintain components as Ruby objects for readability and ease of use while keeping ERB support right in.

visit: [demo](https://rails-ui-9389388c40ad.herokuapp.com/rails_ui)

## Usage

RailsUi is currently in alpha, and the components are designed to be copied directly into your Rails application. Each component follows the ViewComponent contrib sidecar approach, meaning that all files related to a specific component are organized in their own folder, making it easy to manage and customize.

> A direct integration can be done too, docs coming soon, in any case the ./test/dummy app is an example on how we integrate the components in an automatic way.

## CLI, 
> generator to copy the components will be available soon. But you call the components directly or by copy them after mount the app.

## Mountable app.

To get the catalog of components you can mount the app in your router:
> mount RailsUi::Engine => "/rails_ui"


## Tailwind support

Check the [Tailwind config example from test app](https://github.com/michelson/rails-ui/blob/main/test/dummy/config/tailwind.config.js)



## Installation
Add this line to your application's Gemfile:

```ruby
gem "rails_ui"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_ui
```

## Run Development Mode

### Install Dependencies in Dummy App
To set up the dummy app used for development, run:
```bash
./bin/setup
```

### Run Dummy App
To run the dummy app:
```bash
./bin/dev
```


# Examples: 


## Avatar 
```erb
<%= render(RailsUi::Avatar::Component.new(alt: 'John Doe')) %>
```

## Button


```erb
  <%= render(RailsUi::Button::Component.new(variant: :secondary, size: :lg)) { "Secondary Large Button" }
  %>
```

```erb
<%= render(RailsUi::ComponentPreview::Component.new(title: "Button with Icon")) do |component| %>
  <% component.with_example do %>
    <%= render(RailsUi::Button::Component.new) do |component| %>
      <% component.icon do %>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-8.707l-3-3a1 1 0 00-1.414 1.414L10.586 9H7a1 1 0 100 2h3.586l-1.293 1.293a1 1 0 101.414 1.414l3-3a1 1 0 000-1.414z" clip-rule="evenodd" />
        </svg>
      <% end %>
      Button with Icon
    <% end %>
  <% end %>
```

## Contributing
Feel free to use, fork and improve this project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

