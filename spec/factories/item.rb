FactoryGirl.define do
  factory :item, class: Item do 
    item_type 'Item'
    sequence(:title) { |n| "#{n}_item" }
    price 100.0
    description 'Tasty item'
    fat '56'
    carbohydrate '700'
    protein '60'
    calorie '700'
    net_weight '80'
  end
end