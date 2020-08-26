class Plan < ApplicationRecord
  has_and_belongs_to_many :features
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  validates :name, presence: true, length: { maximum: 50 }

  def monthly_fee
    fee = 0.0
    features.each { |f| fee += f.unit_price * f.max_unit_limit }
    fee
  end

end
