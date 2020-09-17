module SubscriptionsHelper
  def billing_day?(day)
    Date.today.day == day
  end

  def charge_able?(subscription)
    billing_day?(subscription.billing_day) && !subscription.transaction_exists?
  end
end
