# frozen_string_literal: true

module Distribuo
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?
      true
    end

    def new?
      create?
    end

    def update?
      true
    end

    def edit?
      update?
    end

    def destroy?
      false
    end

    def event?
      update?
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope.administrable
      end
    end
  end
end
