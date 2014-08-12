require 'faker'

FactoryGirl.define do
  factory :app do
    name 'app name'
    description 'app description'
    user
  end


  factory :user do
    email {Faker::Internet.email}
    password "secret123"
    password_confirmation "secret123"

    factory :user_with_apps do
      ignore do
        apps_count  5
      end

      after(:create) do |user, evaluator|
        create_list(:app, evaluator.apps_count, user: user)
      end
    end
  end

end
