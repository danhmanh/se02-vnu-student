class CreateCourseDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :course_details do |t|
      t.string :room_name
      t.string :day_of_week
      t.string :start_time
      t.string :duration
      t.references :course
    end
  end
end
