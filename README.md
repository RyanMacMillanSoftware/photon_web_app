# photon_web_app
Developer: Ryan MacMillan

A web project for a small research group. New tools to come. 

Important features:

User authentication (email authentication)

Admin priviledges

Exclusive permissions for some tools

User lists and profiles

A time punching system to record staff movements

Database -> Spreadsheet downloading

To run (on linux):

1 Download the source code / clone

2 Open a console, navigate to the top folder of the project

3 Use command "rails console"

4 Open a browser and navigate to your local host

(optional) To access the website you need an initial User (preferably admin)

5 Open another console, navigate to the top folder of the project

6 Use command: rails console

7 Use command: User.new(name: "Your Name", email: "your_email@address.com", password: "choose_a_password", password_confirmation:                                     "choose_a_password", admin: true, authenticated: true)
                
8 Log in using your email and password in the browser

Feedback most welcome.              
