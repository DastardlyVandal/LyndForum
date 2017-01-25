# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

boards = Board.create([{ name: 'General' }, { name: 'News' }, { name: 'Politics' }, { name: 'Technology' } ])
user1 = User.create! name: 'Naomi', email: 'a@a.com', password: 'aaaaaa', role: 0
user2 = User.create! name: 'Franki', email: 'b@b.com', password: 'bbbbbb', role: 1
user3 = User.create! name: 'Hunter', email: 'c@c.com', password: 'cccccc', role: 2
