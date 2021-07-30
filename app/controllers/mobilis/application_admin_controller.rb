# frozen_string_literal: true

require_dependency 'mobilis/application_controller'
require_dependency 'concerns/mobilis/respond'

module Mobilis
  class ApplicationAdminController < ApplicationController
    include Pundit
    include Respond
    include Mobilis.config.admin_authentication_module.constantize if Mobilis.config.admin_authentication_module
  end
end
