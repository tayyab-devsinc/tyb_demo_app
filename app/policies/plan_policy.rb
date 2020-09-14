class PlanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  permit_admin_to :new, :create, :edit, :update, :destroy

  def show?
    true
  end

  def subscribe?
    !admin?
  end

end
