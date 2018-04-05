FactoryBot.define do
  factory :user do
    email FFaker::Internet.email
    password 'TestTest'
    login FFaker::Name.first_name
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    birthday FFaker::IdentificationESCO.expedition_date
    address '24 tytova'
    city 'dnipro'
    state 'dnipropetrovsk'
    country 'ukraine'
    zip FFaker::AddressUA.zip_code
  end
  factory :admin, class: User do
    email FFaker::Internet.email
    password 'TestTest'
    login FFaker::Name.first_name
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    birthday FFaker::IdentificationESCO.expedition_date
    address '24 tytova'
    city 'dnipro'
    state 'dnipropetrovsk'
    country 'ukraine'
    zip FFaker::AddressUA.zip_code
    role 'admin'
  end
  factory :moderator, class: User do
    email FFaker::Internet.email
    password 'TestTest'
    login FFaker::Name.first_name
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    birthday FFaker::IdentificationESCO.expedition_date
    address '24 tytova'
    city 'dnipro'
    state 'dnipropetrovsk'
    country 'ukraine'
    zip FFaker::AddressUA.zip_code
    role 'moderator'
  end
end
