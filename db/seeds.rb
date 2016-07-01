# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tool = Tool.new(base_price: 3, available: false)
tool2 = Tool.new(base_price: 5)
tool3 = Tool.new(base_price: 5)
tool4 = Tool.new(base_price: 2, available: false)
user = User.new
user.tools << tool
user.tools << tool2
user.tools << tool3
user.tools << tool4
user.sum_all_tools