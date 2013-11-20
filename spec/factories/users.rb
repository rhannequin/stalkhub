# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.username   { Faker::Name.name }
    f.avatar_url { Faker::Lorem.characters(10) }
    f.token      { Faker::Lorem.characters(10) }
    f.uid        { Faker::Lorem.characters(10) }
  end
end
