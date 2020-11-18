module Mobilis
  class Configuration
    attr_accessor :admin_authentication_module, :base_controller
    attr_writer :logger, :admin_mount_point, :current_mobiliable, :mobiliable_objects

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @base_controller = '::ApplicationController'
    end

    # logger [Object].
    def logger
      @logger.is_a?(Proc) ? instance_exec(&@logger) : @logger
    end

    # admin_mount_point [String].
    def admin_mount_point
      @admin_mount_point ||= '/mobilis'
    end

    # Only used to limit what users can see when using admin
    def mobiliable_objects
      [*instance_exec(&@mobiliable_objects)] if @mobiliable_objects
    end

    # Used to set current scribable, used when creating new sites or importing sites
    def current_mobiliable
      instance_exec(&@current_mobiliable) if @current_mobiliable
    end
  end
end
