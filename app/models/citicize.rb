class Citicize < ApplicationRecord
  mount_uploader :artwork, ArtworkUploader
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :estimates, dependent: :destroy
  has_many :estimates_users, through: :estimates, source: :user
  has_many :comments, dependent: :destroy
end
