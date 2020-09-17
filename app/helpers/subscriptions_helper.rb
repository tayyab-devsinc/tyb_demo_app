module SubscriptionsHelper
  def billing_day?(day)
    Date.today.day == day
  end

  def transaction_present?(subscription)
    subscription.transactions.where('created_at::date = ?', Date.today).exists?
  end
end
