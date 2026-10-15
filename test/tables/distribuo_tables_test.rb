require 'test_helper'
require 'mensa/testing'

class DistribuoTablesTest < ActiveSupport::TestCase
  # Use explicit records: release upload callbacks are unrelated to table rendering.
  self.fixture_table_names = []

  setup do
    Distribuo::Download.delete_all
    Distribuo::Release.delete_all
    Distribuo::App.delete_all
    @user = User.create!(name: 'Table administrator')
    @app = Distribuo::App.create!(name: 'Mobile Alpha', operating_system: 'ios', release_type: 'beta')
    @app.icon.attach(io: StringIO.new(Base64.decode64('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jRZkAAAAASUVORK5CYII=')), filename: 'icon.png', content_type: 'image/png')
    @other_app = Distribuo::App.create!(name: 'Mobile Beta', operating_system: 'android')
    now = Time.current
    @release_id = SecureRandom.uuid
    @empty_id = SecureRandom.uuid
    Distribuo::Release.insert_all!([
      {id: @release_id, app_id: @app.id, position: 2, version: '2.0', build_number: '42', bundle_id: 'org.example.mobile', created_at: now, updated_at: now},
      {id: @empty_id, app_id: @other_app.id, position: 1, version: '1.0', build_number: nil, bundle_id: nil, created_at: now, updated_at: now}
    ])
    ['127.0.0.1', '127.0.0.1', '127.0.0.2', nil].each do |ip|
      Distribuo::Download.create!(distribuo_release_id: @release_id, ip: ip)
    end
  end

  test 'download counts preserve distinct non-null IPs and zero downloads' do
    rows = Distribuo::ReleasesTable.new.selected_scope.index_by(&:id)
    assert_equal 2, rows.fetch(@release_id).unique_downloads
    assert_equal 4, rows.fetch(@release_id).total_downloads
    assert_equal 2, rows.fetch(@release_id).release
    assert_equal 0, rows.fetch(@empty_id).total_downloads
    assert_equal 0, rows.fetch(@empty_id).unique_downloads
  end

  test 'release params isolate embedded records and survive navigation' do
    table = Mensa.for_name('distribuo/releases', params: {app_id: @app.id})
    assert_equal [@release_id], table.selected_scope.map(&:id)
    assert_equal({app_id: @app.id}, table.navigation_context.fetch(:params))
    assert_equal [@release_id, @empty_id].sort, Distribuo::ReleasesTable.new.selected_scope.map(&:id).sort
    assert_empty Distribuo::ReleasesTable.new(params: {app_id: SecureRandom.uuid}).selected_scope
  end

  test 'English and Dutch model and displayed column translations are explicit' do
    [Distribuo::AppsTable, Distribuo::ReleasesTable].each do |klass|
      table = klass.new
      key = table.model.model_name.i18n_key
      [:en, :nl].each do |locale|
        [:one, :other].each do |plural|
          assert I18n.exists?("activerecord.models.#{key}.#{plural}", locale, fallback: false)
        end
        table.display_columns.each do |column|
          assert I18n.exists?("activerecord.attributes.#{key}.#{column.name}", locale, fallback: false), "#{locale}: #{key}.#{column.name}"
        end
      end
    end
  end

  test 'Mensa verifies populated tables and both scoped branches' do
    # Equal timestamps exercise stable ordering and the last page, too.
    now = Time.current
    Distribuo::App.insert_all!(30.times.map { |i| {id: SecureRandom.uuid, name: "Page app #{i}", created_at: now, updated_at: now} })
    Distribuo::Release.insert_all!(30.times.map { |i| {id: SecureRandom.uuid, app_id: @app.id, position: i + 3, version: "3.#{i}", created_at: now, updated_at: now} })
    [:en, :nl].each do |locale|
      I18n.with_locale(locale) do
        assert_mensa_table_valid Distribuo::AppsTable, user: @user, strict: true
        assert_mensa_table_valid Distribuo::ReleasesTable, user: @user, strict: true
      end
    end
    assert_mensa_table_valid Distribuo::ReleasesTable, user: @user, strict: true
    assert_mensa_table_valid Distribuo::ReleasesTable, user: @user, strict: true, params: {app_id: @app.id}
    assert_mensa_table_valid Distribuo::ReleasesTable, user: @user, strict: true, params: {app_id: @other_app.id}
  end
end
