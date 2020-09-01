class Plan < ApplicationRecord
  has_and_belongs_to_many :features

  validates :name, presence: true, length: { maximum: 50 }
  validates :monthly_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
