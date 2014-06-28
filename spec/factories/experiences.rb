# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experience do
    company_name { Faker::Company.name }
    company_website { Faker::Internet.url }
    title { Faker::Lorem.word }
    ignore do 
      year_for_start { rand(10) }
    end
    description { Faker::Lorem.words.join(" ") }
    user

    before(:create) do |user, e|
      start_date e.year_for_start.years.ago
      end_date (e.year_for_start + 1).years.ago
    end
  end
end
