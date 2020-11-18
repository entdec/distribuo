# frozen_string_literal: true

module Mobilis
  class ReleasePolicy < ApplicationPolicy
    def permitted_attributes
      return [] unless user.admin?

      %i[app_id version notes build]
    end
  end
end
