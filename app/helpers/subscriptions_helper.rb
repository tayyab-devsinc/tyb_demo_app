module SubscriptionsHelper
  def billing_day?(day)
    Date.today.day == day
  end

  def charge_able?(subscription)
    billing_day?(subscription.billing_day) && !subscription.transaction_exists?
  end

  def plan_class(plan_id)
    current_user&.subscribed?(plan_id) ? 'plan color-1 four columns' : 'plan color-2 four columns'
  end

  def plan_features(plan)
    plan.features.map(&:name).join(', ')
  end
end
