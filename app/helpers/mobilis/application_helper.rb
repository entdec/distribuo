module Mobilis
  module ApplicationHelper
    def mobilis_apps_menu
      Satis::Menus::Builder.build(:apps) do |m|
        m.item :create, icon: 'fal fa-plus', link: mobilis.new_admin_app_path
      end
    end

    def mobilis_app_menu
      Satis::Menus::Builder.build(:app) do |m|
        m.item :releases, icon: 'box_open', link: admin_app_releases_path(@app) if @app&.persisted?
      end
    end

    def mobilis_app_releases_menu
      Satis::Menus::Builder.build(:app_releases) do |m|
        m.item :new, label: 'New', link: new_admin_app_release_path(@app)
      end
    end

    def method_missing(method, *args, &block)
      if main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    end
  end
end
