class UsagePolicy < ApplicationPolicy
  permit_admin_to :new, :create, :edit, :update
end
