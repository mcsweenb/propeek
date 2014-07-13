# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profession do
    name { Faker::Lorem.word }
  end

  trait :an_accountant do
    name 'Accountant'
  end

end
