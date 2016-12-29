FactoryGirl.define do
  factory :user, class: User do
    name 'User'    
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    admin false
  end

  factory :admin, class: User do
    name 'Admin'    
    sequence(:email) { |n| "email_#{n}@test.com" }
    sequence(:password) { |n| "#{n}"*8 }
    admin true
  end
end