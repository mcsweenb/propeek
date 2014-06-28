# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :education do
    qualification { Faker::Lorem.words.join(" ") }
    institution { Faker::Company.name }
    ignore do 
      year_for_start { rand(10) }
    end
    description { Faker::Lorem.words.join(" ") }
    user

    before(:create) do |user, e|
      user.start_date = e.year_for_start.years.ago
      user.end_date = (e.year_for_start + 1).years.ago
    end
  end
end
