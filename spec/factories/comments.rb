FactoryBot.define do
  factory :comment do
    body FFaker::LoremRU.paragraph
    association :post
    association :user
  end
end
