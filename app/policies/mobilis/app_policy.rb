# frozen_string_literal: true

module Mobilis
  class AppPolicy < ApplicationPolicy
    def permitted_attributes
      return [] unless user.admin?

      %i[name release_type operating_system icon]
    end
  end
end
