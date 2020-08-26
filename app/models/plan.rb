class Plan < ApplicationRecord
  has_and_belongs_to_many :features
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  validates :name, presence: true, length: { maximum: 50 }
  validates :monthly_fee, presence: true
end
