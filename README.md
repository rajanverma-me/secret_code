# PERFORM THESE STEPS IN ORDER TO USE THE APPLICATION

This app is a part of recuitment test. I thought to make it open sp you can use the code as per the provided guidelines, read following steps to get familiar to the application. 

* Do the bundle install

* Make your own config/database.yml and secrets.yml
(or you can replace guser and gpass with your email and pass in development.rb)

* Do db:create, db:migrate.

* After running server, you will be shown "/" home_controller's index function. Which is not publically accessible. So you will be redirected to devise's login page. 

* Here you can try to sign up, but it will not continue; until admin provide some secret codes to select. 

* So you have to create an admin user through console. i.e
 User.create(first_name: "atc", last_name: "asd", email: "sample@sam.co", password: "sample123")

* Assign it the role ':admin' using rolify syntax. i.e. user.add_role :admin

* give him the ability to manage all using cancancan. ie. Ability.new(user)  

* After creating the admin, use those credentials to login. You will be redirected to "/" after successful login. 

* Then go to "/secrets" to generate some codes. Use the button on interface provided. "/secrets" route is only accessible to admin. 

* Create desired number of codes. Codes generated will be shown on same page only to admin. 

* Install Redis. and run 'bundle exec sidekiq' to activate background jobs. 

* After codes creation, logout and try signup with some random EMAILID. 

* click on "Send code to above email" to get code on email. Note that code will be valid only for 30 minutes from generation. 

* User need to fill the correct code in order to create the account. 

* Then go to "/", you will see your email id and associated code. 

* Logout and sign in with admin credentials, go to "/secrets" .. All generated code with their association will be displayed adjacently.. for non associated code. "N/A" will be displayed. 

* COMMENTS are provided where ever necessary in code

* Please contact if something is not clear
