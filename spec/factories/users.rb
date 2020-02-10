FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "exampleuser#{n}@example.com" }
    sequence(:username) { |n| "user-#{n}" }
    password {'password'}
    password_confirmation {'password'}
    is_site_admin {false}
    activated {false}
    activated_at {nil}

    trait :admin do
      is_site_admin {true}
    end

    trait :activated do
      activated { true }
      activated_at { Time.now }
    end

  end
end