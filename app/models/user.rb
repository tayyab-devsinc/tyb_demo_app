class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_photo, AvatarUploader

  validates_presence_of :profile_photo
  validates_integrity_of :profile_photo
  validates_processing_of :profile_photo

end
