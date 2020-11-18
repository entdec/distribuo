# frozen_string_literal: true

module Mobilis
  class AppsTable < ApplicationTable
    model App

    column(:icon) { |app| image_tag(main_app.url_for(app.icon.variant(resize_to_limit: [20, 20]))) }
    column(:name)
    column(:release_type)
    column(:operating_system)
    column(:created_at)

    filter(:platform)

    initial_order :created_at, :desc

    row_link { |app| mobilis.admin_app_path(app) }

    private

    def scope
      @scope = policy_scope(App).all
      @scope
    end
  end
end
