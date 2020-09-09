class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions
  has_many :transactions, through: :subscriptions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_photo, AvatarUploader

  validates_presence_of :profile_photo
  validates_integrity_of :profile_photo
  validates_processing_of :profile_photo

  def subscribed?(plan)
    subscriptions.find_by(plan_id: plan.id)
  end
end
