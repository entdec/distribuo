# frozen_string_literal: true

module ActiveRecordHelpers
  extend ActiveSupport::Concern

  class_methods do
    def mobiliable
      has_many :apps, as: :mobiliable, class_name: 'Distribuo::App'
    end
  end
end
