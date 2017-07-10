# photon_web_app
Developer: Ryan MacMillan
contact: rmac460@aucklanduni.ac.nz || ryanmacmillan1996@gmail.com

A web project for a research group. A time punching system to record staff movements.

An in depth manual will be added as "documentation.pdf"

To run (on linux):

1 Download the source code / clone

2 Open a console, navigate to the top folder of the project

3 Use command "rails server"

4 Open a browser and navigate to your local host

(optional) To access the website you need an initial User (preferably admin)

5 Open another console, navigate to the top folder of the project

6 Use command: "rails console"

7 Use command: u = User.new(name: "Your Name", email: "your_email@address.com", password: "choose_a_password", password_confirmation: "choose_a_password", authenticated: true, microfab: true, admin: true)
                
8 Use command: u.save 

9 Exit console "quit"

10 Log in using your email and password in the browser

Feedback most welcome.              
