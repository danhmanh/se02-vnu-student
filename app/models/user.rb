class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :messages, dependent: :destroy
  has_many :conversations, dependent: :destroy, foreign_key: :sender_id

  mount_uploader :avatar, PictureUploader

  def feed
    Post.where("user_id = ?", id)
  end
end
