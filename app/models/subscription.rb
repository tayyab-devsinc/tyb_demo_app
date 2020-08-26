class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :transactions
  has_many :usages, dependent: :destroy
end
