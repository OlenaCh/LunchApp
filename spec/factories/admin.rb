FactoryGirl.define do
  factory :admin, class: Admin do
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
  end
end