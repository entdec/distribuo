module Distribuo
  class Engine < ::Rails::Engine
    isolate_namespace Distribuo

    def self.mounted_path
      route = Rails.application.routes.routes.detect do |route|
        route.app == self
      end
      route && route.path
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match? root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
