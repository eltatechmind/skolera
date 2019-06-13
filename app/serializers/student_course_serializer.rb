class StudentCourseSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :student
  belongs_to :course
end
