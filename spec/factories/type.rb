FactoryGirl.define do
  factory :type, class: Type do
    sequence(:title) { |n| "#{n}_type" }
  end
end