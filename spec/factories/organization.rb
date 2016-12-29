FactoryGirl.define do
  factory :organization, class: Organization do
    sequence(:title) { |n| "#{n}_organization" }
    sequence(:address) { |n| "#{n}_address" }
    sequence(:email) { |n| "#{n}_mail@gmail.com" }
    phone '789-000-000'
  end
end