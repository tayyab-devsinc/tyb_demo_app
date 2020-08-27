class Plan < ApplicationRecord
  has_and_belongs_to_many :features

  accepts_nested_attributes_for :features

  validates :name, presence: true, length: { maximum: 50 }
  validates :monthly_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def add_features(features_params)
    features_params&.each do |fid|
      fr = Feature.find(fid)
      features << fr
    end
  end

end
