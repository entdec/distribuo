module Distribuo
  class App < ApplicationRecord
    has_one_attached :icon

    belongs_to :mobiliable, polymorphic: true, optional: true
    has_many :releases

    scope :administrable, -> { all }

    OPERATING_SYSTEMS = [
      %w[iOS ios],
      %w[Android android],
      %w[Windows windows],
      %w[MacOS macos],
      %w[tvOS tvos]
    ].freeze

    RELEASE_TYPES = %w[alpha beta enterprise production store].freeze

    def latest_release
      releases.first
    end
  end
end
