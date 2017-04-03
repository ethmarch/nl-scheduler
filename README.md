# db-project
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

