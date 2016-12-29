FactoryGirl.define do
  factory :item, class: Item do  
    sequence(:title) { |n| "#{n}_item" }
    price 100.0
    image 'picture.png'
  end
end