FactoryBot.define do
  factory :student_course do
    transient do
      student_id { nil }
      course_id { nil }
    end
    before(:create) do |student_course, evaluator|
      student_course.student_id = evaluator.student_id
      student_course.course_id = evaluator.course_id
    end
  end
end