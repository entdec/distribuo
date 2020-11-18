# frozen_string_literal: true

class AppsController < ApplicationController
  before_action :authenticate_user!, except: :manifest

  def show; end

  def manifest; end
end
