#1. Prerequisite Configuration
import os
import sys
import bottle
import json
import mysql.connector
import psycopg2
import urlparse

# urlparse.uses_netloc.append("postgres")
# url = urlparse.urlparse(os.environ["postgres://ygqehxjv:q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf@echo.db.elephantsql.com:5432/ygqehxjv"])
# Return status of MySQL database
# -bottle.route registers the index route to this function
@bottle.route('/')
def index():
    conn = psycopg2.connect(
            database="ygqehxjv",
            user="ygqehxjv",
            password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
            host="echo.db.elephantsql.com",
            port="5432"
            )
    #Catch any possible exceptions and print them to webpage when thrown
    try:
        #use these by default
        host = '127.0.0.1'
        port = 3306
        dbusername = 'root'
        dbpassword = 'root'
        dbname = 'starwarsFINAL'   

        #4. Make Connection to MySQL DB
        # con = mysql.connector.connect(host = host, user = dbusername, password = dbpassword, database = dbname , port = port)
        cursor = conn.cursor()


        cursor.execute("SELECT * FROM student")
        result = cursor.fetchall()
        return str(result)

        #Close the database connection
        cursor.close()
        con.close()
 
        #print the result
        return '<title>MySQL Status </title> MySQL connection successful. <h5><p>%s</p></h5>' % (result) 

    except Exception as err:
        # return 500 error if any exceptions are thrown and report exceptions via webpage
        bottle.abort(500, "%s" % (err)) 

@bottle.route('/hello')
def hello():
    return "Hello World!"

#return custon 404 error page
@bottle.error(404)
def error404(error):
    return '404 Error! This page does not exist!'

#instantiate instance of bottle app
application = bottle.default_app()

if __name__ == '__main__':
    # check for port to listen on from environment variables
    port = int(os.getenv('PORT', '8000'))
    bottle.run(host='0.0.0.0', port=port)
