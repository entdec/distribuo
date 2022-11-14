module Distribuo
  class ApplicationController < Distribuo.config.base_controller.constantize
    protect_from_forgery with: :exception
  end
end
