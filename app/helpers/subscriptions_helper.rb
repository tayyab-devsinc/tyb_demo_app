module SubscriptionsHelper
  def is_billing_day?(day)
    Date.today.day == day
  end

  def subscription_features
    @subscription.plan.features.map { |x| [x.name, x.id] }
  end
end
