FactoryBot.define do
  factory :category do
    association :sub_wiki, strategy: :null
    sequence(:name) {|n| "Category-#{n}" }
  end
end