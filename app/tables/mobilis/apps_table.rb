# frozen_string_literal: true

module Mobilis
  class AppsTable < ApplicationTable
    model App

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
