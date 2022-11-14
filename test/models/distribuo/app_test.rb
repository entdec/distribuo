require 'test_helper'

module Distribuo
  class ApplicationTest < ActiveSupport::TestCase
    test 'can create an app' do
      subject = Distribuo::App.create(name: 'Smurrelufts')
    end
  end
end
