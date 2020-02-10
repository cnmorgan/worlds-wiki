FactoryBot.define do
  factory :world do
    association :owner, factory: :user, strategy: :build
    sequence(:name) { |n| "World#{n}" }
    is_private { false }
  end
end