################################### users ############################################
# user 1 is demo user
User.create!(username:              'a',
               email:               'a',
               encrypted_password:  'a',
               address:             'A Street #8, Ayville, AA 88888')

18.times do
  User.create!(username:            Faker::Internet.user_name,
               email:               Faker::Internet.email,
               encrypted_password:  'password',
               address:             Faker::Internet.address)
end

# user 20 will only have a basic profile to test UX of a new user
User.create!(username:              'z',
               email:               'z',
               encrypted_password:  'z',
               address:             'z')


################################### abstract tools ###################################
# create 20 abstract tools
abstract_tools = ['metal detector', 'wheel barrow', 'shovel', 'pitchfork', 'post hole digger', 'rake', 'axe', 'table saw', 'pickaxe', 'wrench', 'broom', 'sledge hammer', 'tape measure', 'bolt cutters', 'screwdriver', 'hammer', 'hand grinder', 'ladder', 'paintbrush', 'jackhammer']

abstract_tools.each do |tool|
  AbstractTool.create!(name: tool)
end


################################### tools ############################################
# create tools for demo user to own/lend
4.times do
  Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         'available',
               owner_id:          1)
end

# create tools for demo user to rent/borrow
4.times do
  Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:        rand(5..50),
               available:         'available',
               owner_id:          rand(2..19))
end


################################### line items #########################################
# create first 4 line_items for demo user to lend tools
for i in 1..4 do
  LineItem.create!(tool_id:    i,
                   rental_id:  i)
end

# create next four line_items for other users to lend tools to demo user
for i in 5..8 do
  LineItem.create!(tool_id:    i,
                   rental_id:  i)
end

# create tool_id 9 to pad line_item
Tool.create!(abstract_tool_id:  rand(1..20),
               base_price:      rand(5..50),
               available:       'available',
               owner_id:        2)

# pad rentals number 1 with an extra item to test multiple line_item functionality
LineItem.create!(tool_id:    9,
                 rental_id:  1)


################################### rentals ################################################
# create 8 rentals for user 1, two of each possible stage of rental life-cycle, one as an owner and one as a renter
Rental.create!(renter_id:       1,
               owner_id:        rand(2..19),
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

Rental.create!(renter_id:       1,
               owner_id:        rand(2..19),
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

Rental.create!(renter_id:       1,
               owner_id:        rand(2..19),
               status:          'in progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

Tool.find(3).status = 'unavailable'

Rental.create!(renter_id:       1,
               owner_id:        rand(2..19),
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))

Rental.create!(renter_id:       rand(2..19),
               owner_id:        1,
               status:          'pending',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

Rental.create!(renter_id:       rand(2..19),
               owner_id:        1,
               status:          'scheduled',
               checkout_date:   Faker::Date.forward(1),
               return_date:     Faker::Date.forward(15))

Rental.create!(renter_id:       rand(2..19),
               owner_id:        1,
               status:          'in progress',
               checkout_date:   Faker::Date.backward(7),
               return_date:     Faker::Date.forward(7))

Tool.find(7).status = 'unavailable'

Rental.create!(renter_id:       rand(2..19),
               owner_id:        1,
               status:          'closed',
               checkout_date:   Faker::Date.backward(30),
               return_date:     Faker::Date.backward(2))


