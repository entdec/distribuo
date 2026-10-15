require 'test_helper'

class TableViewsTest < ActionView::TestCase
  self.fixture_table_names = []

  # The card belongs to the host UI library. Capture its real Slim block while
  # recording the Mensa call, so request context cannot silently be lost.
  class Cards
    attr_reader :options

    def initialize(view)
      @view = view
    end

    def card(_name, **options, &block)
      @options = options
      @view.capture(nil, &block)
    end
  end

  test 'standalone apps view builds the namespaced Mensa table' do
    assert_table_view 'distribuo/admin/apps/index', 'distribuo/apps', {}
  end

  test 'standalone releases view forwards the app ID to Mensa' do
    @app = Distribuo::App.new(id: SecureRandom.uuid)
    assert_table_view 'distribuo/admin/apps/releases/index', 'distribuo/releases', {app_id: @app.id}
  end

  private

  def assert_table_view(template, name, params)
    cards = Cards.new(view)
    calls = []
    view.define_singleton_method(:sts) { cards }
    view.define_singleton_method(:distribuo_apps_menu) { [] }
    view.define_singleton_method(:distribuo_app_releases_menu) { [] }
    view.define_singleton_method(:table) do |table_name, **options|
      calls << [table_name, options]
      '<div>table</div>'.html_safe
    end
    render template: template
    assert_equal [[name, {params: params}]], calls
    assert_equal false, cards.options.fetch(:content_padding)
    assert_includes rendered, 'table'
  end
end
