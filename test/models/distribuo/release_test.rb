require 'test_helper'

module Distribuo
  class ReleaseTest < ActiveSupport::TestCase
    test 'uses Rubyzip 3' do
      assert_equal '3', Zip::VERSION.split('.').first
    end

    test 'uploaded IPA populates release metadata and app icon' do
      app = Distribuo::App.create!(name: 'ZIP upload', operating_system: 'ios')
      upload = Rack::Test::UploadedFile.new('test/files/oms.ipa', 'application/octet-stream')
      release = app.releases.create!(build: upload)

      assert_equal '91', release.reload.build_number
      assert_equal '2.0.0', release.version
      assert_equal 'com.boxture.mobile.OMS', release.bundle_id
      assert app.reload.icon.attached?
      assert_equal [152, 152], ImageSize.new(app.icon.download).size
    end

    test 'retrieves details from apk' do
      apk = Distribuo::PackageParser.parse('test/files/oms.apk')

      assert_equal '100', apk.version
      assert_equal '2.0.0', apk.version_string
      assert_equal 'android', apk.os
      assert_equal 'mobile.boxture.com.oms', apk.bundle_id

      icon = apk.icons.reject do |i|
        i[:dimensions].nil?
      end.max { |i| i[:dimensions]&.first.to_i }[:file_name]

      assert_equal 'res/mipmap-xxxhdpi-v4/ic_launcher.png', icon
      assert_equal [192, 192], ImageSize.new(apk.icon_data(icon)).size
    end

    test 'retrieves details from ipa' do
      ipa = Distribuo::PackageParser.parse('test/files/oms.ipa')

      assert_equal '91', ipa.version
      assert_equal '2.0.0', ipa.version_string
      assert_equal 'ios', ipa.os
      assert_equal 'com.boxture.mobile.OMS', ipa.bundle_id

      icon = ipa.icons.reject do |i|
        i[:dimensions].nil?
      end.max { |i| i[:dimensions]&.first.to_i }[:file_name]

      assert_equal 'AppIcon76x76@2x~ipad.png', icon
      assert_equal [152, 152], ImageSize.new(ipa.icon_data(icon)).size
    end
  end
end
