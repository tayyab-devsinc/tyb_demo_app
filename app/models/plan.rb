class Plan < ApplicationRecord
  has_and_belongs_to_many :features

  validates :name, presence: true
  validates :monthly_fee, presence: true

  def monthly_fee
    fee = 0.0
    features.each { |f| fee += f.unit_price * f.max_unit_limit }
    fee
  end

  def add_features(features_params)
    features_params&.each do |fid|
      fr = Feature.find(fid)
      features << fr
    end
  end

end
