class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def self.permit_admin_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        admin?
      end
    end
  end

  def admin?
    @user.admin
  end
end
