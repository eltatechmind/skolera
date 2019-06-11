FactoryBot.define do
  factory :student do
    name { Faker::Lorem.word }
  end
end