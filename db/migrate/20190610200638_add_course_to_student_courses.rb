class AddCourseToStudentCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :student_courses, :course_id, :integer
    add_index :student_courses, :course_id
  end
end
