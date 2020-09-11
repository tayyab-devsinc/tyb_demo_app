class Transaction < ApplicationRecord
  belongs_to :subscription
  belongs_to :user

  def self.make_transaction(subscription)
    t = Transaction.new
    t.subscription_id = subscription.id
    t.user_id = subscription.user_id
    t.amount = Usage.calculate_fee(subscription)
    if t.save
      print('TRANSACTION DONE')
    else
      print('TRANSACTION FAIL')
    end
  end

  def self.daily_transaction
    subs = Subscription.all.where(billing_day: Date.today.day)
    subs.each do |s|
      make_transaction(s)
    end
  end
end
