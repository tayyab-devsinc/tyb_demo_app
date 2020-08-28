class Usage < ApplicationRecord
  belongs_to :subscription
  belongs_to :feature

  accepts_nested_attributes_for :feature
  accepts_nested_attributes_for :subscription

end
