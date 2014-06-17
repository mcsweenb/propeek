FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'abcde'
    password_confirmation 'abcde'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    bio Faker::Lorem.paragraphs.first
    linkedin_handle Faker::Lorem.characters(20)
    twitter_handle Faker::Lorem.characters(10)
  end
end
