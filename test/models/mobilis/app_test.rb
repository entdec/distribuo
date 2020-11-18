require 'test_helper'

module Mobilis
  class ApplicationTest < ActiveSupport::TestCase
    test 'can create an app' do
      subject = Mobilis::App.create(name: 'Smurrelufts')
    end
  end
end
