class AddTeacherToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :teacher_id, :integer
    add_index :courses, :teacher_id
  end
end
