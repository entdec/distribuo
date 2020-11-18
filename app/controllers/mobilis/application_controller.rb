module Mobilis
  class ApplicationController < Mobilis.config.base_controller.constantize
    protect_from_forgery with: :exception
  end
end
