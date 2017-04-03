# nlp-sql-interface
Final project for CS 3200 Database Design at Northeastern University

This is an IBM Bluemix app that can be deployed using CloudFoundry through terminal on your local machine.

Make sure you have the CloudFoundry tap for terminal installed, if you don't follow these steps :
https://github.com/cloudfoundry/cli#downloads


1. Clone the repo

2. Navigate to /bluemix-code

3. Install the dependencies for the app: pip install -r requirements.txt

4. To run the app locally: python wsgi.py
   The app will run on http://0.0.0.0:8000/
   To see the changes you make locally you may have to restart the server each time you save a file,
   not sure if this is just on my machine, but if the page doesn't reload, just restart the server.

5. To push to the BlueMix app first: cf api https://api.ng.bluemix.net

6. Then log into CloudFoundry: cf login
   Enter your username and password when prompted

7. When you are done making changes locally, you can push the app to the live site with: cf push db-project

To access the site the link is https://db-project.mybluemix.net


Ensure that when you want to push to the repo again, your terminal is at the db-project/ level, not the 
bluemix-code level. Git wants to read that folder as a submodule if you push from there, and we will have to reset 
the repo if that gets turned into a submodule again. 

We are using the Bottle framework for connecting and interacting with SQL through Python, they have good tutorials:
http://bottlepy.org/docs/dev/index.html

The app uses ElephantSQL, which is a PostgresSQL distribution, which is hosted in the cloud. DO NOT CHANGE THE USERNAME AND PASSWORD IN THE wsgi.py FILE FOR THE CONNECTION. In order to add to the database, go to 
https://console.ng.bluemix.net/dashboard/apps 

Then choose db-project, click on ElephantSQL-g4 under 'Connections', and then click 'Open Dashboard'

Then click on the 'Browser' tab on the top and an interface to insert in values to the database will come up.
You can create tables, add values, and do other SQL commands in the box. 
MAKE SURE YOU USE SINGLE QUOTES '' INSTEAD OF DOUBLE QUOTES WHEN DEFINING STRING VALUES, IF NOT IT WON'T WORK.



