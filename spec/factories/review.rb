# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review, :class => 'Review' do
    review_for
    review_by
    review { Faker::Lorem.words.join(" ") }
    rating { rand (5) }
  end
end
