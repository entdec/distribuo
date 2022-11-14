require 'test_helper'

module Distribuo
  class ReleaseTest < ActiveSupport::TestCase
    test 'retrieves details from apk' do
      apk = AppParser.parse('test/files/oms.apk')

      assert_equal '100', apk.version
      assert_equal '2.0.0', apk.version_string
      assert_equal 'android', apk.os
      assert_equal 'mobile.boxture.com.oms', apk.bundle_id

      icon = apk.icons.reject do |i|
        i[:dimensions].nil?
      end.max { |i| i[:dimensions]&.first.to_i }[:file_name]

      assert_equal 'res/mipmap-xxxhdpi-v4/ic_launcher.png', icon
    end

    test 'retrieves details from ipa' do
      ipa = AppParser.parse('test/files/oms.ipa')

      assert_equal '91', ipa.version
      assert_equal '2.0.0', ipa.version_string
      assert_equal 'ios', ipa.os
      assert_equal 'com.boxture.mobile.OMS', ipa.bundle_id

      icon = ipa.icons.reject do |i|
        i[:dimensions].nil?
      end.max { |i| i[:dimensions]&.first.to_i }[:file_name]

      assert_equal 'AppIcon76x76@2x~ipad.png', icon
    end
  end
end
