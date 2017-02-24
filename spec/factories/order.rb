FactoryGirl.define do
  factory :order, class: Order do
    name 'User'
    address 'Address'
    email 'email@gmail.com'
    status 'Confirmed'
  end
end