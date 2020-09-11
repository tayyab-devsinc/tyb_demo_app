class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  validates :feature_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.calculate_fee(subscription)
    fee = subscription.plan.monthly_fee
    usages = Usage.all.where(subscription_id: subscription.id)
    usages.each do |u|
      fee += u.feature.unit_price * (u.feature_count - u.feature.max_unit_limit) if u.feature_count > u.feature.max_unit_limit
    end
    fee
  end
end
