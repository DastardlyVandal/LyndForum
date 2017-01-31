# LyndForum

LyndForum is a Bulletin Board Software written using Ruby on Rails with Bootstrap and Devise.

This is a personal project that I am building on the side, as a learning exercise to learn Ruby on Rails. The main purpose for this is to be a general purpose forum software that scales well to mobile, while not losing any visual aesthetic on other platforms. It includes a voting mechanic so user's can garner a reputation.

At a later point, I will include scheduled tasks that will generate a moderation queue for users with a low reputation at the end of every day.

[Demo](http://ec2-52-34-41-44.us-west-2.compute.amazonaws.com:3000/)

## Installation

(I will write distro-specific installation instructions at a later date)

Clone the repo:

    $ git clone https://github.com/DastardlyVandal/LyndForum.git

Move into the newly cloned repo and bundle install

    $ cd LyndForum/ && bundle install


Before you run your migrations, you'll want to change the values in seeds.rb

    $ (vi/nano/gedit/etc.) db/seeds.rb

Populate this as you deem fit. Ensure you change the admin user's password, or add them through your database manually.

Run:

    $ rake db:migrate
    $ rails s


## Customization

All the styles will be stored in app/assets/, and can be configured from there.

Points of interest would be:

    app/assets/images/logo.png
    app/assets/stylesheets/constants.css

The Navbar uses logo.png for the brand logo, and the color scheme is located in constants.css

## Other Notes

This is a work in progress, and there are still changes that are planned to be made. This is not something that I would use in production at the moment.
