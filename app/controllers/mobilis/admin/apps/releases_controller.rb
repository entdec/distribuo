# frozen_string_literal: true

require_dependency 'mobilis/application_admin_controller'

module Mobilis
  module Admin
    module Apps
      class ReleasesController < ApplicationAdminController
        before_action :set_objects

        def new
          render :edit
        end

        def create
          authorize @release
          respond(@release.update(permitted_attributes(@release)), action: :index)
        end

        def show
          render :edit
        end

        def edit; end

        def update
          authorize @release
          respond @release.update(permitted_attributes(@release))
        end

        private

        def set_objects
          @app = policy_scope(App).find(params[:app_id]) if params[:app_id]
          @release = @app.releases.find(params[:id]) if params[:id]
          @release ||= @app.releases.new
        end
      end
    end
  end
end
