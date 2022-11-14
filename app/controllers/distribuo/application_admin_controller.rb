# frozen_string_literal: true

require_dependency 'distribuo/application_controller'
require_dependency 'concerns/distribuo/respond'

module Distribuo
  class ApplicationAdminController < ApplicationController
    include Pundit
    include Respond
    include Distribuo.config.admin_authentication_module.constantize if Distribuo.config.admin_authentication_module
  end
end
