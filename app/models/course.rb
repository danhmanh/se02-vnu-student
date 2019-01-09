class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_details, dependent: :destroy
  has_one :group, dependent: :destroy
end
