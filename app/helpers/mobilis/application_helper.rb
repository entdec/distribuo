module Mobilis
  module ApplicationHelper
    def app_edit_context_menu
      @app_edit_context_menu ||= Electio::Menu.new(context: self) do |menu|
        if @app&.persisted?
          menu.item :app_edit, label: @app.name, link: '#' do |submenu|
            submenu.item :releases, icon: 'box_open', link: admin_app_releases_path(@app) if @app&.persisted?
          end
        end
      end
      @app_edit_context_menu.for_context
    end

    def releases_index_context_menu
      @releases_index_context_menu ||= Electio::Menu.new(context: self) do |menu|
        menu.item :releases_index, label: 'New', link: new_admin_app_release_path(@app) do |submenu|
        end
      end
      @releases_index_context_menu.for_context
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
