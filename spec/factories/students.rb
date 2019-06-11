FactoryBot.define do
  factory :student do
    name { Faker::Lorem.characters(20) }
  end
end