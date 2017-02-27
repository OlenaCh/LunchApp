FactoryGirl.define do
  factory :order, class: Order do
    name 'Devoted User'
    address 'User Address'
    email 'email@gmail.com'
    status 'Confirmed'
  end
end