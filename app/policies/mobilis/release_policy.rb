# frozen_string_literal: true

module Mobilis
  class ReleasePolicy < ApplicationPolicy
    def permitted_attributes
      return [] unless user.admin?

      %i[id app_id version notes build build_number bundle_id]
    end
  end
end
