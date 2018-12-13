class CreateUserCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|
      t.references :user
      t.references :course
      t.float :score4
      t.float :score10
      t.string :score_str
    end
  end
end
