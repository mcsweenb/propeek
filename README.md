# Requirements

* Ruby 2.1.2
* Rails 4.1.1
* PostgresSQL, 9.1 or above

## Setup

### Database

- Install postgresql server, client and development libraries
- Create a user
- Create two databases ```propeek_development``` and ```propoeek_test```
- Set up ```pg_hba.conf``` so you can connect to the database with required permissions for the user you created above
- We'll get to how to tell rails where your database is a bit later
- We need to make sure we have postgres dev libraries installed else the ruby driver installation will fail otherwise

### The application

- Install rvm. Follow instructions at (rvm.io)[http://rvm.io]
- Using rvm install ruby 2.1.2. If things have moved on just use the latest 2.1 on rvm.
- Using rvm create a gemset called propeek (or any other name)
- Checkout this repos in a directory, say called propeek
- CD into the propeek directory and do ```rvm --ruby-version use 2.1.2@propeek``` [Use the ruby version number here as the one you installed]
- Do ```bundle install```
- Set up database connection as described in next section
- run ```bundle exec rake db:migrate```

#### Database connection

- Copy ```config/database.yml.example``` to ```config/database.yml``` and provide the connection details there.
- Just the database username, password and the hostname is all that is needed

### Running the server

Simplest way to start the server is to 

- cd into propeek directory
- run ```bundle exec rails server```
- you'll get a server running on localhost:3000

#### Getting a rails console

- cd into propeek directory
- run ```bundle exec rails console```

## Upgrade instructions

Coming soon
