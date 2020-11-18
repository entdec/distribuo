# frozen_string_literal: true

module Mobilis
  class AppsController < ApplicationController
    before_action :set_objects

    def index; end

    private

    def set_objects
      @apps = Mobilis.config.current_mobiliable.apps
      @apps = Moblis::App.all if @apps.count == 0
    end
  end
end
