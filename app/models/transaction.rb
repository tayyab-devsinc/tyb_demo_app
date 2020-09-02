class Transaction < ApplicationRecord
  belongs_to :subscription
  belongs_to :user

  def self.subscription_transaction(subscription)
    transaction = Transaction.new(subscription_id: subscription.id, user_id: subscription.user_id, amount: subscription.plan.monthly_fee)
    transaction.save
  end
end
