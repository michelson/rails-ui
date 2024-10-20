# module RailsUi
#  class Engine < ::Rails::Engine
#    isolate_namespace RailsUi
# end
# end

require "view_component"
require "view_component/engine"

module RailsUi
  class Engine < ::Rails::Engine
    isolate_namespace RailsUi

    config.autoload_paths << root.join("app", "ui", "components")

    config.view_component.preview_paths << root.join("app/ui")
    # config.view_component.preview_route = "/rails_ui/previews"

    # config.autoload_paths << root.join("app/ui")

    initializer "rails_ui.assets.precompile" do |app|
      app.config.assets.precompile += %w[rails_ui.js]
    end

    initializer "ui.view_component" do |app|
      ActiveSupport.on_load(:view_component) do
        # Extend your preview controller to support authentication and other
        # application-specific stuff
        #
        # Rails.application.config.to_prepare do
        #   ViewComponentsController.class_eval do
        #     include Authenticated
        #   end
        # end
        #
        # Make it possible to store previews in sidecar folders
        # See https://github.com/palkan/view_component-contrib#organizing-components-or-sidecar-pattern-extended
        ViewComponent::Preview.extend ViewComponentContrib::Preview::Sidecarable
        # Enable `self.abstract_class = true` to exclude previews from the list
        ViewComponent::Preview.extend ViewComponentContrib::Preview::Abstract
      end

      # require "view_component/contrib"
    end
  end
end
