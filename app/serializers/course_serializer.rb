class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  belongs_to :teacher
  has_many :student_courses
end
