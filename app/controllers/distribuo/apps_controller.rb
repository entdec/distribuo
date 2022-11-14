# frozen_string_literal: true

module Distribuo
  class AppsController < ApplicationController
    before_action :set_objects

    def index; end

    private

    def set_objects
      @apps = Distribuo.config.current_mobiliable.apps
      @apps = Distribuo::App.all if @apps.count == 0
    end
  end
end
