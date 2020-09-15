class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.includes(:plan)
      else
        scope.where(user: user).includes(:plan)
      end
    end
  end

  permit_admin_to :charge
end
