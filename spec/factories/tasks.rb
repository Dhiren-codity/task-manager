FactoryBot.define do
  factory :task do
    association :user
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    status { "pending" }
    priority { "medium" }
    due_date { 7.days.from_now.to_date }

    trait :completed do
      status { "completed" }
      completed_at { Time.current }
    end

    trait :in_progress do
      status { "in_progress" }
    end

    trait :high_priority do
      priority { "high" }
    end

    trait :urgent do
      priority { "urgent" }
    end

    trait :overdue do
      due_date { 2.days.ago.to_date }
      status { "pending" }
    end
  end
end
