class Feature < ApplicationRecord
  has_and_belongs_to_many :plans

  validates :name, presence: true, length: { maximum: 50 }
  validates :code, presence: true, length: { maximum: 50 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_unit_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
