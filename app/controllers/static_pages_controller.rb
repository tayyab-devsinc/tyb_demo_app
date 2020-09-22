class StaticPagesController < ApplicationController
  before_action :set_counts, only: [:home]
  before_action :authenticate_user!, only: [:home]

  def home
    @transactions = policy_scope(Transaction).paginate(page: params[:page], per_page: 10)
  end

  private

  def set_counts
    @counts = { feature_count: Feature.count,
                plan_count: Plan.count,
                subscription_count: Subscription.count,
                user_count: User.count }
  end
end
