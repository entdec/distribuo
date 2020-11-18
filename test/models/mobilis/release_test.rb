require 'test_helper'

module Mobilis
  class ReleaseTest < ActiveSupport::TestCase
    test 'retrieves details from apk' do
      apk = AppParser.parse('test/files/oms.apk')

      assert_equal '100', apk.version
      assert_equal '2.0.0', apk.version_string
      assert_equal 'android', apk.os
      assert_equal 'mobile.boxture.com.oms', apk.bundle_id
      assert_equal 'res/mipmap-xxxhdpi-v4/ic_launcher.png', apk.icons.reject { |i| i[:dimensions].nil? }.max { |i| i[:dimensions]&.first.to_i }[:file_name]
    end

    test 'retrieves details from ipa' do
      ipa = AppParser.parse('test/files/oms.ipa')

      assert_equal '91', ipa.version
      assert_equal '2.0.0', ipa.version_string
      assert_equal 'ios', ipa.os
      assert_equal 'com.boxture.mobile.OMS', ipa.bundle_id
      assert_equal 'AppIcon76x76@2x~ipad.png', ipa.icons.reject { |i| i[:dimensions].nil? }.max { |i| i[:dimensions]&.first.to_i }[:file_name]
    end
  end
end
