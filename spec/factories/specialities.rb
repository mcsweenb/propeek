# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speciality do
    name Faker::Lorem.words.join(" ")
  end
end
