# frozen_string_literal: true

module Mobilis
  class ReleasesTable < ApplicationTable
    model Release

    column(:release, &:position)
    column(:bundle_id)
    column(:version)
    column(:build_number, &:build_number)
    column(:unique_downloads) { |row| row.downloads.distinct.count(:ip) }
    column(:total_downloads) { |row| row.downloads.count }
    column(:created_at)

    filter(:version)

    initial_order :created_at, :desc

    row_link { |release| mobilis.edit_admin_app_release_path(release.app, release) }

    private

    def scope
      @scope = Release.all
      @scope = @scope.where(app_id: params[:app_id]) if params[:app_id]
      @scope
    end
  end
end
