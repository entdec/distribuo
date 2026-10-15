# frozen_string_literal: true

module Distribuo
  class ReleasesTable < ApplicationTable
    model Distribuo::Release

    supports_custom_views true
    show_header true
    exportable true

    internal :id
    internal :app_id

    column(:release) do
      attribute 'distribuo_releases.position'
      type :integer
    end
    column(:bundle_id)
    column(:version) do
      filter
    end
    column(:build_number)
    column(:unique_downloads) do
      attribute '(SELECT COUNT(DISTINCT distribuo_downloads.ip) FROM distribuo_downloads WHERE distribuo_downloads.distribuo_release_id = distribuo_releases.id)'
      type :integer
    end
    column(:total_downloads) do
      attribute '(SELECT COUNT(*) FROM distribuo_downloads WHERE distribuo_downloads.distribuo_release_id = distribuo_releases.id)'
      type :integer
    end
    column(:created_at)

    order created_at: :desc, id: :desc
    link { |release| distribuo.edit_admin_app_release_path(release.app_id, release.id) }

    scope do
      records = Distribuo::Release.all
      records = records.where(app_id: params[:app_id]) if params[:app_id]
      records
    end
  end
end
