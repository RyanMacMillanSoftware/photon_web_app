# Photon Web App
Developer: Ryan MacMillan
Contact: rmac460@aucklanduni.ac.nz || ryanmacmillan1996@gmail.com
A time punching system to record staff movements in a lab and to track the usage of equipment. 
### Dependencies
Ruby on Rails and PostgresSQL must be installed on the system.
### To run (on linux):
1 Download and unzip the latest release
2 Open a terminal in the parent folder of the directory
3 Install the Gems
```sh
bundle install
``` 
4 Set up the development database
```sh
rails db:migrate RAILS_ENV=DEVELOPMENT
rails db:fixtures:load
```
5 Launch the local development server
```sh
rails server
```
6 Open a browser and navigate to your local host
### Creating your first user
Modifications to the database can be made in the rails console 
```sh
rails console
```
You will need a user to log in to the software. I recommend giving your first user  permission to access both the "microfab" and "fabrication" parts of the web app. 
```sh
 user = User.new(name: "Admin", email: "a@a.com", password: "rrrrrr", password_confirmation: "rrrrrr", activated: true, microfab: true, fabrication: true)
 user.save
```
Also, create an admin (admins have access to the entire site by default)
```sh
 admin = User.new(name: "Admin", email: "a@a.com", password: "rrrrrr", password_confirmation: "rrrrrr", activated: true, admin: true)
 admin.save
```
You can edit a user by using the update_attributes command
```sh
admin = User.find_by(email: "a@a.com")
admin.update_attributes(name: "NoLongerAdmin", admin: false)
```
Exit the console
```sh
quit
```