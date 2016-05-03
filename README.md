# Rails Appointments

A Rails app for keeping track of appointments, clients and multiple locations.  

### Features

* Keep track of appointments with multiple clients in multiple locations 
* Reschedule or cancel appointments as needed. 
* Add Clients and Locations and track appointments by client and location. 
* Keep track of income earned from clients and/or locations.

## Installation 


```
cd rails-appointments
bundle install
```

The repo doesn't include the database.yml or secrets.yml files, so you'll need to paste in these commands to copy them into the project.

```

cat > config/database.yml << EOF
# MySQL.  Versions 5.0+ are recommended.
#
# Install the MYSQL driver
#   gem install mysql2
#
# Ensure the MySQL gem is defined in your Gemfile
#   gem 'mysql2'
#
# And be sure to use new-style password hashing:
#   http://dev.mysql.com/doc/refman/5.0/en/old-client.html
#
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
  socket: /var/run/mysqld/mysqld.sock

development:
  <<: *default
  database: dlm_appointments_development

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: dlm_appointments_test

# As with config/secrets.yml, you never want to store sensitive information,
# like your database password, in your source code. If your source code is
# ever seen by anyone, they now have access to your database.
#
# Instead, provide the password as a unix environment variable when you boot
# the app. Read http://guides.rubyonrails.org/configuring.html#configuring-a-database
# for a full rundown on how to provide these environment variables in a
# production deployment.
#
# On Heroku and other platform providers, you may have a full connection URL
# available as an environment variable. For example:
#
#   DATABASE_URL="mysql2://myuser:mypass@localhost/somedatabase"
#
# You can use this database configuration with:
#
#   production:
#     url: <%= ENV['DATABASE_URL'] %>
#
production:
  <<: *default
  database: dlm_appointments_production
  username: dlm_appointments
  password: <%= ENV['DLM_APPOINTMENTS_DATABASE_PASSWORD'] %>

EOF

```

```
cat > config/secrets.yml << EOF

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.

development:
  secret_key_base: 63e714c3159506599d6211ab437d192ae27eb5398de7ee196d286681f68573f90a1ccd3a50ae6912fbbd57b95b56adafb1a5d147165ba5a32806f6b3a111a7d9

test:
  secret_key_base: 4c849f4fa74a2298973f143f416e11865c48dc354b0c1508cde7dcbaf9981200c0d4b64d14889d9818827017e453506a3385cc52fb2613219701277dadf66500

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  google_analytics_code: YOUR CODE HERE
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

EOF
```

(Cloud9 Only)
```
mysql-ctl start
```

```
rake db:create
rake db:migrate
```

### Facebook Login

In order to get the Facebook Login working correctly, you'll need to complete the following steps:

1. Create an application in the [Facebook Developer Console](https://developer.facebook.com/) and go to the settings part of the Dashboard (skip quick setup) 
2. At the top of the **Basic** tab, you'll see the name of the app, the API version, the **App ID**, and the **App Secret**.  You'll want to add the App ID and the App Secret to the `.env` file in your project, like so... In the root of your project, run `nano .env`, and add the following:
```
FACEBOOK_KEY="App ID here"
FACEBOOK_SECRET="App Secret here"
```
Press `CTRL + O` to save, hit return to save the file as `.env`, press `CTRL + X` to exit nano.
3. Drop into your `rails console` to make sure you've got them hooked up: run `ENV["FACEBOOK_KEY"]` and you should see your App ID **NOTE:** If this isn't working, make sure that you have the `gem 'dotenv-rails, groups: [:development, :test]` in your Gemfile **beneath** `gem rails`.
4. **Before making any commits:** Make sure you that you have `.env` in your `.gitignore` file.
5. Click on the **Advanced** Tab and scroll down to the section labeled **Client OAuth Settings** and find the filed labeled **Valid OAuth Redirect URLs**.  You'll want to add `http://localhost:3000/users/auth/facebook/callback`.

Now you should be able to run 
```
rails server 
```
and test out the app.

## Usage 

1. Sign up for an account 
2. Click the "+ New" button at the top of the page
3. Fill in the form on the left to create your first client and appointment (i.e. Fill in Top field with "My first client", and the bottom field with "My first location")
4. Click the Create Appointment Button 
5. Your new appointment should appear on your calendar.
6. To Reschedule your appointment, click on the appointment in your calendar and you'll be taken to the edit appointment form. Make your changes and submit the form to change your appointment. 
7. Click on the Clients link in the top navigation menu and you should see a list of your clients ("My first client" should be at the top). Click on the edit button below the client's name to add contact information.  
8. In the right hand column there is a button to add a new appointment with "My first client".
9. Click on the Locations link in the top navigation menu and you'll see a list of your locations ("My first location" should be at the top). Click on the edit button below the location's name to add an address.
10. In the right hand column there is a button to add a new appointment at "My first location".

