FactoryGirl.define do
  factory :weekday, class: Weekday do
    sequence(:day) { |n| "#{n}_weekday" }
  end
end