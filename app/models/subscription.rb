class Subscription < ApplicationRecord
  validates :billing_day, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 28 }

  belongs_to :user
  belongs_to :plan
  has_many :transactions

  before_validation :set_subscription_parameters
  after_save :subscription_transaction

  private

  def set_subscription_parameters
    self.billing_day = Date.today.day > 28 ? 28 : Date.today.day
    self.subscription_date = Date.today
  end

  def subscription_transaction
    Transaction.create(subscription_id: id, user_id: user_id, amount: plan.monthly_fee)
  end
end
