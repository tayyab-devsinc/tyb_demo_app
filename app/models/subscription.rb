class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :transactions

  validates :billing_day, presence: true, inclusion: 1..28

  before_validation :set_billing_day
  after_save :subscription_transaction

  private

  def set_billing_day
    self.billing_day = [Date.today.day, 28].min
  end

  def subscription_transaction
    transactions.create(user_id: user_id, amount: plan.monthly_fee)
  end
end
