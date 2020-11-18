module Mobilis
  class Download < ApplicationRecord
    belongs_to :release, class_name: 'Release', foreign_key: 'mobilis_release_id'
  end
end
