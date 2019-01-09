class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  scope :desc, -> { order created_at: :desc }
  scope :feed, -> (following_ids, id){
    Post.where("user_id IN (?)
      OR user_id = (?)", following_ids, id)
  }

  mount_uploader :picture, PictureUploader
end
