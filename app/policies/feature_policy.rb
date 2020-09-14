class FeaturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  permit_admin_to :new, :create, :edit, :update, :destroy

  # def new?
  #   user_is_admin?
  # end
  #
  # def create?
  #   user_is_admin?
  # end
  #
  # def update?
  #   user_is_admin?
  # end
  #
  # def destroy?
  #   user_is_admin?
  # end
  #
  # private
  #
  # def user_is_admin?
  #   @user.admin
  # end
end
