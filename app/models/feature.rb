class Feature < ApplicationRecord
  has_and_belongs_to_many :plans
  has_many :usages

  validates :name, presence: true
  validates :code, presence: true
  validates :unit_price, presence: true
  validates :max_unit_limit, presence: true
end
