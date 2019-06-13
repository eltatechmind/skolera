class StudentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  has_many :student_courses
end
