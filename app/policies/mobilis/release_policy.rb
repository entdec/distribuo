# frozen_string_literal: true

module Mobilis
  class ReleasePolicy < Mobilis::ApplicationPolicy
    def permitted_attributes
      return [] unless user.is_admin?

      %i[id app_id version notes build build_number bundle_id]
    end
  end
end
