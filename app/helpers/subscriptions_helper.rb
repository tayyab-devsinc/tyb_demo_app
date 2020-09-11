module SubscriptionsHelper

  def is_billing_day?(day)
    Date.today.day==day
  end
end
