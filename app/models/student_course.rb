class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course
  validates :course_id, uniqueness: { scope: :student_id }
end
