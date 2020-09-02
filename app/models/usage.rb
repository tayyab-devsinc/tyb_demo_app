class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  accepts_nested_attributes_for :feature
  accepts_nested_attributes_for :subscription

  validates :feature_count, presence: true, numericality: {greater_than_or_equal_to: 0}

  def self.calculate_fee(subscription)
    fee = subscription.plan.monthly_fee
    print("\n\n MFee :  #{fee}\n\n")
    usages = Usage.all.where(subscription_id: subscription.id)
    usages.each do |u|
      print("\n u.feature_count: #{u.feature_count}
       \n u.feature.max_unit_limit: #{u.feature.max_unit_limit}
            \n u.feature.unit_price * u.feature_count : #{u.feature.unit_price * u.feature_count}\n")
      fee += u.feature.unit_price * (u.feature_count - u.feature.max_unit_limit) if u.feature_count > u.feature.max_unit_limit
    end
    print("\n\n #{fee}\n\n")
    fee
  end
end
