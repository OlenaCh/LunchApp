# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#               email: email,
#               password:              password,
#               password_confirmation: password)
# end

days = Weekday.create([{order_number: 0, day: 'Sunday'}, {order_number: 1, 
                      day: 'Monday'}, {order_number: 2, day: 'Tuesday'},
                      {order_number: 3, day: 'Wednesday'}, {order_number: 4,
                      day: 'Thursday'}, {order_number: 5, day: 'Friday'},
                      {order_number: 6, day: 'Saturday'}])
                      
types = Type.create([{title: 'First course'}, {title: 'Main course'}, 
                    {title: 'Drink'}])