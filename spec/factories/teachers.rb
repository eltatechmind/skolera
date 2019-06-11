FactoryBot.define do
  factory :teacher do
    name { Faker::Lorem.characters(20) }
    trait :admin do
      admin { true }
    end
  end
end