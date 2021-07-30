# frozen_string_literal: true

require_dependency 'mobilis/application_admin_controller'

module Mobilis
  module Admin
    class AppsController < ApplicationAdminController
      before_action :set_objects, except: [:index]

      def new
        render :edit
      end

      def create
        authorize @app
        @app.update(permitted_attributes(@app))
        respond_with @app, action: :index
      end

      def show
        render :edit
      end

      def edit; end

      def update
        authorize @app
        @app.update(permitted_attributes(@app))
        respond_with @app, action: :index
      end

      private

      def set_objects
        @app = Mobilis::App.find(params[:id]) if params[:id]
        @app ||= Mobilis::App.new
      end
    end
  end
end
