FactoryBot.define do
  factory :user do
    email FFaker::Internet.email
    password 'TestTest'
    login FFaker::Name.first_name
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    birthday FFaker::IdentificationESCO.expedition_date
    address FFaker::AddressUA.street_address
    city FFaker::AddressUA.city
    state FFaker::AddressUA.province
    country FFaker::AddressUA.country
    zip FFaker::AddressUA.zip_code
  end
end
