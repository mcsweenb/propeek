FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'abcde'
    password_confirmation 'abcde'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    bio { Faker::Lorem.sentence[0..255] }
    linkedin_handle { Faker::Lorem.characters(20) }
    twitter_handle { Faker::Lorem.characters(10) }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    profession

    ignore do
      memberships_count 10
      specialities_count 10
      languages_count 2
    end
    
    after(:create) do |user, evaluator|
      create_list(:membership, evaluator.memberships_count, users: [user])
      create_list(:speciality, evaluator.specialities_count, profession: user.profession, users: [user])
      create_list(:language, evaluator.languages_count, users: [user])
    end
  end

end
