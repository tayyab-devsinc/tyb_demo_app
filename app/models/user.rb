class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_photo, AvatarUploader

  validates_presence_of :profile_photo
  validates_integrity_of :profile_photo
  validates_processing_of :profile_photo
end
