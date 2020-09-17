class FeaturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  permit_admin_to :new, :create, :edit, :update, :destroy
end
