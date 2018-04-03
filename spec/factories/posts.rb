FactoryBot.define do
  factory :post do
    text FFaker::LoremRU.paragraph
    association :user
  end
end
