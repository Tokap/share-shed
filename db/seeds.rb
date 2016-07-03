User.destroy_all
Tool.destroy_all
Rental.destroy_all
LineItem.destroy_all

################################### users ############################################
# user 1 is demo user
first_user = User.create!(username:    'a',
             email:       'a@a.com',
             password:    'aaaaaaaa',
             address:     '707 Broadway, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '1048 Seventh Ave, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '2920 Zoo Dr, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '222 Island Ave, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '100 Park Blvd, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '1788 El Prado, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '1492 N Harbor Dr, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '1451 Washington St, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '950 Sixth Ave, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '880 Harbor Island Dr, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '1717 University Ave, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '5680 Mission Center Rd, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '500 Sea World Dr, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '2345 Fenton Pkwy, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '650 Gateway Center Dr, San Diego, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '2100 Costa Del Mar Rd, Carlsbad, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '425 Santa Fe Dr, Encinitas, CA')

User.create!(username:  Faker::Internet.user_name,
             email:     Faker::Internet.email,
             password:  'password',
             address:   '2260 Jimmy Durante Blvd, Del Mar, CA')

User.create!(username:  Faker::Internet.user_name,
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
# create tools for demo user to own/lend
5.times do
  Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             first_user)
end

# create tools for demo user to rent/borrow
4.times do
  Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         true,
               owner:             last_user)
end

# create tool_id 9 to pad line_item
Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:      rand(5..50),
               available:       true,
               owner:           last_user)


################################### rentals ################################################
# create 8 rentals for user 1, two of each possible stage of rental life-cycle, one as an owner and one as a renter
first_user_borrowing_1 = Rental.create!(renter:          first_user,
               owner:           last_user,
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

first_user_borrowing_2 = Rental.create!(renter:          first_user,
               owner:           last_user,
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

first_user_borrowing_3 = Rental.create!(renter:          first_user,
               owner:           last_user,
               status:          'in_progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

Tool.find(3).available = false

first_user_borrowing_4 = Rental.create!(renter:          first_user,
               owner:           last_user,
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))

first_user_renting_out_1 = Rental.create!(renter:          last_user,
               owner:           first_user,
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

first_user_renting_out_2 = Rental.create!(renter:          last_user,
               owner:           first_user,
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

first_user_renting_out_3 = Rental.create!(renter:          last_user,
               owner:           first_user,
               status:          'in_progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

Tool.find(7).available = false

first_user_renting_out_4 = Rental.create!(renter:          last_user,
               owner:           first_user,
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))


################################### line items #########################################
# create first 4 line_items for demo user to lend tools
  LineItem.create!(tool:    first_user.tools[0],
                   rental:  first_user_renting_out_1)

  LineItem.create!(tool:    first_user.tools[1],
                   rental:  first_user_renting_out_2)

  LineItem.create!(tool:    first_user.tools[2],
                   rental:  first_user_renting_out_3)

  LineItem.create!(tool:    first_user.tools[3],
                   rental:  first_user_renting_out_4)


# create next four line_items for other users to lend tools to demo user

  LineItem.create!(tool:    last_user.tools[0],
                   rental:  first_user_borrowing_1)

  LineItem.create!(tool:    last_user.tools[1],
                   rental:  first_user_borrowing_2)

  LineItem.create!(tool:    last_user.tools[2],
                   rental:  first_user_borrowing_3)

  LineItem.create!(tool:    last_user.tools[3],
                   rental:  first_user_borrowing_4)

# pad rentals number 1 with an extra item to test multiple line_item functionality
LineItem.create!(tool:    first_user.tools[4],
                 rental:  first_user_renting_out_1)
