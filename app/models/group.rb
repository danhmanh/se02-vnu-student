class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts, dependent: :destroy
  belongs_to :course

  scope :desc, -> { order created_at: :desc }
end
