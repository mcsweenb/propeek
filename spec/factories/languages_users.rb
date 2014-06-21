# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :languages_user, :class => 'LanguagesUsers' do
    language_id 1
    user_id 1
  end
end
