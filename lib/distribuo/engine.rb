module Distribuo
  class Engine < ::Rails::Engine
    isolate_namespace Distribuo

    def self.mounted_path
      route = Rails.application.routes.routes.detect do |route|
        route.app == self
      end
      route && route.path
    end
  end
end
