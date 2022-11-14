# frozen_string_literal: true

module Distribuo
  class AppPolicy < Distribuo::ApplicationPolicy
    def permitted_attributes
      return [] unless user.admin?

      %i[name release_type operating_system icon]
    end
  end
end
