class Feature < ApplicationRecord
  has_and_belongs_to_many :plans

  validates :name, presence: true
  validates :code, presence: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_unit_limit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
