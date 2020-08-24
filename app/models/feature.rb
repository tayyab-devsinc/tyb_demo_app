class Feature < ApplicationRecord
  has_and_belongs_to_many :plans
  validates :name, presence: true, length: { maximum: 50 }
  validates :code, presence: true, length: { maximum: 50 }
  validates :unit_price, presence: true
  validates :max_unit_limit, presence: true
end
