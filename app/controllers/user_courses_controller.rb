class UserCoursesController < ApplicationController
  before_action :logged_in_user

  def index
    crawl_data_from_list
    @course_details = []
    current_user.courses.each do |course|
      course.course_details.each do |course_details|
        @course_details.push(course_details)
      end
    end

  end
end
