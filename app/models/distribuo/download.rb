module Distribuo
  class Download < ApplicationRecord
    belongs_to :release, class_name: 'Release', foreign_key: 'distribuo_release_id'
  end
end
