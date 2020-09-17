class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :transactions
  has_many :usages, dependent: :destroy

  validates :billing_day, presence: true, inclusion: 1..28

  before_validation :set_billing_day
  after_save :subscription_transaction

  def charge_fee
    subscription_transaction if billing_day == Date.today.day
  end

  private

  def set_billing_day
    self.billing_day = [Date.today.day, 28].min
  end

  def subscription_transaction
    transactions.create(user_id: user_id, amount: monthly_fee_calculation)
  end

  def monthly_fee_calculation
    fee = plan.monthly_fee
    usages.greater_count_usages.each do |u|
      fee += u.feature.unit_price * (u.feature_count - u.feature.max_unit_limit)
    end
    fee
  end
end
