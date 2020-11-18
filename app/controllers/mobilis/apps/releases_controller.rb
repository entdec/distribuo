# frozen_string_literal: true

module Mobilis
  module Apps
    # FIXME: This should probably inherit from an ApplicatoinController
    class ReleasesController < ActionController::Base
      # skip_before_action :authenticate_user!
      before_action :set_objects

      def download
        @release.downloads.create(ip: request.ip)
        send_data @release.build.download, filename: @release.build.filename.to_s, content_type: @release.build.content_type
      end

      def manifest
        render plist: 'manifest.plist.erb'
      end

      private

      def set_objects
        @app = App.find(params[:app_id]) if params[:app_id]
        @release = @app.releases.find(params[:release_id]) if params[:release_id]
      end
    end
  end
end
