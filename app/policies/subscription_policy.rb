class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.includes(:plan, :transactions)
      else
        scope.where(user: user).includes(:plan)
      end
    end
  end

  permit_admin_to :charge

  def destroy?
    true
  end
end
