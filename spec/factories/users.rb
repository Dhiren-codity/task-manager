FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    karma { 0 }

    trait :high_karma do
      karma { 150 }
    end

    trait :banned do
      banned_at { 1.day.ago }
    end
  end
end
