class StaticPagesController < ApplicationController
  before_action :set_counts, only: [:home]
  before_action :authenticate_user!, only: [:home]
  def home
  end

  def help
  end

  def contact
  end

  def about
  end

  private

  def set_counts
    @counts = { feature_count: Feature.count,
                plan_count: Plan.count,
                subscription_count: Subscription.count,
                user_count: User.count }
  end
end
