FactoryGirl.define do
  factory :weekday, class: Weekday do
    sequence(:day) { |n| "#{n}_weekday" }
    order_number 1
  end
end