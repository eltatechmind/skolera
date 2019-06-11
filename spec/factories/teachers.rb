FactoryBot.define do
  factory :teacher do
    name { Faker::Lorem.characters(20) }
  end
end