# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# ['admin', 'finances', 'head_sale', 'manager_sales', 'user'].each do |role|
# Role.find_or_create_by({name: role})
# end

# Role.create name: "leader", description: "Лидер"
# Role.create name: "user", description: "Новичок"
# Role.create name: "vip", description: "VIP Партнер"
# Role.create name: "partner", description: "Партнер"

if Rails.env == "development" then
  u1 = User.create! name: 'Super', last_name: 'Parent', email: 'super@mail.com', password: 'Parent'
  u2 = User.create! name: 'Middle', last_name: 'Parent', email: 'middle@mail.com', password: 'Parent'
  u2.children.create! name: 'Simple', last_name: 'Children', email: 'simple@mail.com', password: 'Children'
  u4 = u1.children.create! name: 'Cool', last_name: 'Children', email: 'cool@mail.com', password: 'Children'
  u4.children.create! name: 'Last', last_name: 'Children', email: 'last@mail.com', password: 'Children'
end
