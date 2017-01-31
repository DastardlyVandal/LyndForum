# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Boards
boards = Board.create([{ name: 'General' }, { name: 'News' }, { name: 'Politics' }, { name: 'Technology' },
    { name: 'Science' }, { name: 'Fashion' }, { name: 'Video Games' }, { name: 'Television' }, { name: 'Anime/Otaku Discussion'} ])

# Users (If this is your first time running this, you /must/ change the passwords)
# A User's role determines what they're capable of doing.
# 0 => admin, 1 => moderator, 2=> User
#Any new users created will start with their role being 2 (user)
admin = User.create! name: 'Naomi', email: 'a@a.com', password: 'aaaaaa', role: 0
moderator = User.create! name: 'Franki', email: 'b@b.com', password: 'bbbbbb', role: 1
user = User.create! name: 'Hunter', email: 'c@c.com', password: 'cccccc', role: 2
