module Mobilis
  class App < ApplicationRecord
    has_one_attached :icon

    belongs_to :mobiliable, polymorphic: true, optional: true
    has_many :releases

    scope :administrable, -> { all }

    def latest_release
      releases.first
    end
  end
end
