class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  validates :feature_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
