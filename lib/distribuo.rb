require 'acts_as_list'
require 'app_parser'
require 'pundit'

require 'distribuo/engine'
require 'distribuo/configuration'
require 'distribuo/active_record_helpers'

module Distribuo
  class Error < StandardError; end

  class << self
    attr_reader :config

    def setup
      @config = Configuration.new
      yield config
    end

    def i18n_store
      @i18n_store ||= Scribo::I18nStore.new
    end

    def logger
      @config.logger
    end
  end

  # Include helpers
  ActiveSupport.on_load(:active_record) do
    include ActiveRecordHelpers
    Mime::Type.register 'application/plist', :plist
  end
end
