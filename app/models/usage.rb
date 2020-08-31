class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  accepts_nested_attributes_for :feature
  accepts_nested_attributes_for :subscription

  validates :feature_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
