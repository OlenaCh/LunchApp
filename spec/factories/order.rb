FactoryGirl.define do
  factory :order, class: Order do
    first_course_id 1
    main_course_id 2
    drink_id 3
    total 20.0
  end
end