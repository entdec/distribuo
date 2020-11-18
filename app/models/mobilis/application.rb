module Mobilis
  class Application < ApplicationRecord
    has_one_attached :icon

    has_many :builds
  end
end
