# frozen_string_literal: true

module Distribuo
  class AppsTable < ApplicationTable
    model Distribuo::App

    supports_custom_views true
    show_header true
    exportable true

    internal :id

    column(:icon) do
      render do
        html do |app|
          app.icon.attached? ? image_tag(main_app.url_for(app.icon.variant(resize_to_limit: [20, 20]))) : ''
        end
        csv { |_app| '' }
      end
    end
    column(:name)
    column(:release_type)
    column(:operating_system) do
      filter do
        collection -> { Distribuo::App::OPERATING_SYSTEMS }
      end
    end
    column(:created_at)

    order created_at: :desc, id: :desc
    link { |app| distribuo.admin_app_path(app.id) }

    scope do
      Distribuo::App.all.with_attached_icon
    end
  end
end
