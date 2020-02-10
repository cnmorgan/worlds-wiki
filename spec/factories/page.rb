FactoryBot.define do
  factory :page do
    association :sub_wiki, strategy: :null
    sequence(:title) { |n| "Page #{n}" }
    content { "" }
  end
end