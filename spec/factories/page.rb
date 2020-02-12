FactoryBot.define do
  factory :page do
    association :sub_wiki, strategy: :null
    sequence(:title) { |n| "Page #{n}" }
    content { "" }
  end

  factory :template, class: Page do
    association :user, strategy: :null
    sequence(:title) { |n| "Page #{n}" }
    content { "" }
  end
end