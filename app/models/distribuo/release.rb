module Distribuo
  class Release < ApplicationRecord
    has_one_attached :build

    belongs_to :app
    has_many :downloads, class_name: 'Download', foreign_key: 'distribuo_release_id', dependent: :destroy

    scope :administrable, -> { all }

    acts_as_list scope: :app_id
    default_scope -> { order(position: :desc) }

    after_save :set_release_details

    def download_url(controller, from_manifest: false)
      if app.operating_system == 'ios' && from_manifest == false
        url = controller.distribuo.app_release_manifest_url(app_id: app.id, release_id: id, host: controller.request.host,
                                                          protocol: controller.request.protocol, format: :plist)
        "itms-services://?action=download-manifest&url=#{url}"
      else
        controller.distribuo.app_release_download_url(app, self, host: controller.request.host,
                                                               protocol: controller.request.protocol)
      end
    end

    private

    def set_release_details
      build_upload = attachment_changes['build'].attachable
      Tempfile.create([File.basename(build_upload.original_filename, File.extname(build_upload.original_filename)),
                       File.extname(build_upload.original_filename)]) do |f|
        f.write build_upload.read.force_encoding('utf-8')
        attachment_changes['build'].attachable.rewind

        ipa = AppParser.parse(f.path)

        updates = {}
        updates[:build_number] = ipa.version unless build_number.present?
        updates[:version] = ipa.version_string unless version.present?
        updates[:bundle_id] = ipa.bundle_id unless bundle_id.present?
        update(updates) if updates.present?

        file_name = ipa.icons.reject { |i| i[:dimensions].nil? }.max { |i| i[:dimensions]&.first.to_i }&.[](:file_name)
        if file_name
          si = StringIO.new
          si.write(ipa.icon_data(file_name))
          si.rewind

          app.icon.attach(io: si, filename: file_name)
        end
      end
      attachment_changes['build'].attachable.rewind
    end
  end
end
