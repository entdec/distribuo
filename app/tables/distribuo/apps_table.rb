# frozen_string_literal: true

module Distribuo
  class AppsTable < ApplicationTable
    model Distribuo::App

    column(:icon) do |app|
      app.icon.attached? ? image_tag(main_app.url_for(app.icon.variant(resize_to_limit: [20, 20]))) : ''
    end
    column(:name)
    column(:release_type)
    column(:operating_system)
    column(:created_at)

    table_views(to_s.underscore)

    filter(:platform)

    initial_order :created_at, :desc

    row_link { |app| distribuo.admin_app_path(app) }

    private

    def scope
      @scope = App.all
      @scope
    end
  end
end
