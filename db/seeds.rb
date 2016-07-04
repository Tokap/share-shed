User.destroy_all
Tool.destroy_all
Rental.destroy_all
LineItem.destroy_all

################################### users ############################################
# user 1 is demo user
demo_user = User.create!(username:    'a',
                         email:       'a@a.com',
                         password:    'aaaaaaaa',
                         address:     '707 Broadway, San Diego, CA')

user_2 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '1048 Seventh Ave, San Diego, CA')

user_3 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '2920 Zoo Dr, San Diego, CA')

user_4 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '222 Island Ave, San Diego, CA')

user_5 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '100 Park Blvd, San Diego, CA')

user_6 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '1788 El Prado, San Diego, CA')

user_7 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '1492 N Harbor Dr, San Diego, CA')

user_8 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '1451 Washington St, San Diego, CA')

user_9 = User.create!(username:  Faker::Internet.user_name,
                      email:     Faker::Internet.email,
                      password:  'password',
                      address:   '950 Sixth Ave, San Diego, CA')

user_10 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '880 Harbor Island Dr, San Diego, CA')

user_11 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '1717 University Ave, San Diego, CA')

user_12 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '5680 Mission Center Rd, San Diego, CA')

user_13 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '500 Sea World Dr, San Diego, CA')

user_14 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '2345 Fenton Pkwy, San Diego, CA')

user_15 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '650 Gateway Center Dr, San Diego, CA')

user_16 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '2100 Costa Del Mar Rd, Carlsbad, CA')

user_17 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '425 Santa Fe Dr, Encinitas, CA')

user_18 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '2260 Jimmy Durante Blvd, Del Mar, CA')

user_19 = User.create!(username:  Faker::Internet.user_name,
                       email:     Faker::Internet.email,
                       password:  'password',
                       address:   '8302 Camino Del Oro, La Jolla, CA')

# user 20 will only have a basic profile to test UX of a new user
last_user = User.create!(username:   'z',
                         email:      'z@z.com',
                         password:   'zzzzzzzzz',
                         address:    '3966 Cleveland Ave, San Diego, CA')


################################### abstract tools ###################################
# create 20 abstract tools
abstract_tools = ['metal detector', 'wheel barrow', 'shovel', 'pitchfork', 'post hole digger', 'rake', 'axe', 'table saw', 'pickaxe', 'wrench', 'broom', 'sledge hammer', 'tape measure', 'bolt cutters', 'screwdriver', 'hammer', 'hand grinder', 'ladder', 'paintbrush', 'jackhammer']

abstract_tools.each do |tool|
  AbstractTool.create!(name: tool)
end


################################### tools ############################################
# create 5 tools for demo user to rent/borrow
user_2_tool = Tool.create!(abstract_tool_id:  rand(1..20),
             base_price:        rand(5..50),
             available:         true,
             owner:             user_2)

user_3_tool = Tool.create!(abstract_tool_id:  rand(1..20),
             base_price:        rand(5..50),
             available:         true,
             owner:             user_3)

user_4_tool = Tool.create!(abstract_tool_id:  rand(1..20),
             base_price:        rand(5..50),
             available:         true,
             owner:             user_4)

user_5_tool = Tool.create!(abstract_tool_id:  rand(1..20),
             base_price:        rand(5..50),
             available:         true,
             owner:             user_5)

# create tools for demo user to own/lend
demo_user_tool_1 = Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             demo_user)

demo_user_tool_2 = Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             demo_user)

demo_user_tool_3 = Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             demo_user)

demo_user_tool_4 = Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             demo_user)

# another tool to test double line item on a rental request
demo_user_tool_5 = Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:      rand(5..50),
               available:       true,
               owner:           demo_user)

################################### rentals ################################################
# demo_user rents tools
demo_user_borrowing_1 = Rental.create!(renter:          demo_user,
               owner:           user_2,
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

demo_user_borrowing_2 = Rental.create!(renter:          demo_user,
               owner:           user_3,
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

demo_user_borrowing_3 = Rental.create!(renter:          demo_user,
               owner:           user_4,
               status:          'in_progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

user_3_tool.available = false

demo_user_borrowing_4 = Rental.create!(renter:          demo_user,
               owner:           user_5,
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))

# demo user lends his tools
demo_user_renting_out_1 = Rental.create!(renter:          user_2,
               owner:           demo_user,
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

demo_user_renting_out_2 = Rental.create!(renter:          user_3,
               owner:           demo_user,
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

demo_user_renting_out_3 = Rental.create!(renter:          user_4,
               owner:           demo_user,
               status:          'in_progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

demo_user_tool_3.available = false

demo_user_renting_out_4 = Rental.create!(renter:          user_5,
               owner:           demo_user,
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))

################################### line items #########################################
# create next four line_items for other users to lend tools to demo user
LineItem.create!(tool:    user_2_tool,
                 rental:  demo_user_borrowing_1)

LineItem.create!(tool:    user_3_tool,
                 rental:  demo_user_borrowing_2)

LineItem.create!(tool:    user_4_tool,
                 rental:  demo_user_borrowing_3)

LineItem.create!(tool:    user_5_tool,
                 rental:  demo_user_borrowing_4)

# create first 4 line_items for demo user to lend tools
LineItem.create!(tool:    demo_user_tool_1,
                 rental:  demo_user_renting_out_1)

LineItem.create!(tool:    demo_user_tool_2,
                 rental:  demo_user_renting_out_2)

LineItem.create!(tool:    demo_user_tool_3,
                 rental:  demo_user_renting_out_3)

LineItem.create!(tool:    demo_user_tool_4,
                 rental:  demo_user_renting_out_4)

# pad rentals number 1 with an extra item to test multiple line_item functionality
LineItem.create!(tool:    demo_user_tool_5,
                 rental:  demo_user_renting_out_1)

# create extra tools to populate search database
dummmy_users = [user_2, user_3, user_4, user_5, user_6, user_7, user_8, user_9, user_10, user_11, user_12, user_13, user_14, user_15, user_16, user_17, user_18, user_19]

dummmy_users.each do |user|
  Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             user)
end

Rental.all.each {|rental| rental.log_line_items }
