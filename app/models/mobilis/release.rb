module Mobilis
  class Release < ApplicationRecord
    has_one_attached :build

    belongs_to :app
    has_many :downloads, class_name: 'Download', foreign_key: 'mobilis_release_id', dependent: :destroy

    scope :administrable, -> { all }

    acts_as_list scope: :app_id
    default_scope -> { order(position: :desc) }

    def download_url(controller, from_manifest = false)
      if app.operating_system == 'ios' && from_manifest == false
        "itms-services://?action=download-manifest&url=#{controller.app_release_manifest_url(app_id: app.id, release_id: id, host: controller.request.host, protocol: controller.request.protocol, format: :plist)}"
      else
        controller.app_release_download_url(app, self, host: controller.request.host, protocol: controller.request.protocol)
      end
    end
  end
end
