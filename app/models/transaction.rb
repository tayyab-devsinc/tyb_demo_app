class Transaction < ApplicationRecord
  belongs_to :subscription
  belongs_to :user

  def self.daily_transaction
    subs = Subscription.all.where(billing_day: Date.today.day)
    subs.each(&:charge_fee)
  end
end
