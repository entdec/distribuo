# frozen_string_literal: true

module Distribuo
  module Respond
    # Informs the user and redirects when needed
    #
    # @param result [Boolean] was update or create succesful
    # @param options [Hash] additional options
    #
    # There is also a list of options that could be used along with validators:
    #
    # * <tt>:path</tt> - Specifies where to redirect to in case of success
    # * <tt>:notice</tt> - What to show on success
    # * <tt>:error</tt> - What to show on error
    # * <tt>:action</tt> - What action to render
    # * <tt>:error_action</tt> - What action to render in case of failure
    # * <tt>:model</tt> - What model to use for auto-generated notice/error flashes
    #
    def respond(result, options = {})
      options[:action]          ||= :index
      options[:error_action]    ||= :edit
      options[:continue_action] ||= options[:error_action]

      respond_flash(result, options)

      if respond_redirect?(result)
        respond_redirect(result, options)
      else
        render result ? options[:continue_action] : options[:error_action]
      end
    end

    private

    def respond_redirect(result, options)
      return unless respond_redirect?(result)

      redirect_to_options   = options[:path] if options.include?(:path)
      redirect_to_options ||= { action: options[:action] }

      redirect_to(redirect_to_options) && return
    end

    def respond_flash(result, options)
      model_name = options[:model_name] || human_model_name(options)

      if !result
        flash.now[:error] = options[:error] || I18n.t('flash.error', model: model_name)
      elsif respond_redirect?(result)
        flash[:notice] = options[:notice] || I18n.t('flash.notice', model: model_name)
      else
        flash.now[:notice] = options[:notice] || I18n.t('flash.notice', model: model_name)
      end
    end

    def respond_redirect?(result)
      return false unless result
      return false if params[:commit] == 'continue'

      true
    end

    def human_model_name(options)
      return options[:model].model_name.human.downcase if options.include?(:model)

      Distribuo.const_get(self.class.name.demodulize.gsub(/Controller$/, '').singularize).model_name.human.downcase
    end
  end
end
