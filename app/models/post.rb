class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
end
