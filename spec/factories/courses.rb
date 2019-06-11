FactoryBot.define do
  factory :course do
    transient do
      teacher_id { nil }
    end
    name { Faker::Lorem.characters(20) }
    before(:create) do |course, evaluator|
      course.teacher_id = evaluator.teacher_id
    end
  end
end