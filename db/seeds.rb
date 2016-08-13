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
Role.create name: "admin", description: "Администратор"
Role.create name: "finances", description: "Финансист"
Role.create name: "head_sale", description: "Руководитель продаж"
Role.create name: "manager_sales", description: "Менеджер продаж"
Role.create name: "user", description: "Пользователь"

User.create name: 'Super', last_name: 'Parent', email: 'super@mail.com', password: 'Parent'
User.create name: 'Middle', last_name: 'Parent', email: 'middle@mail.com', password: 'Parent'
User.find(2).children.create name: 'Simple', last_name: 'Children', email: 'simple@mail.com', password: 'Children'
User.find(1).children.create name: 'Cool', last_name: 'Children', email: 'cool@mail.com', password: 'Children'
User.find(4).children.create name: 'Last', last_name: 'Children', email: 'last@mail.com', password: 'Children'
