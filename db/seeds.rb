# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first

AdminUser.create(first_name: 'Demo', last_name: 'Demo', email: 'demo@gmail.com', username: 'democms1', password: 'democms', password_confirmation: 'democms')
