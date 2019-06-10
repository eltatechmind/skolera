class AddStudentToStudentCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :student_courses, :student_id, :integer
    add_index :student_courses, :student_id
  end
end
