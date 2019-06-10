class AddUniqueIndexToStudentCourses < ActiveRecord::Migration[5.2]
  def change
    add_index :student_courses, [:student_id, :course_id], unique: true
  end
end
