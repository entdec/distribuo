module Mobilis
  class Release < ApplicationRecord
    has_one_attached :build

    belongs_to :application
  end
end
