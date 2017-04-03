#1. Prerequisite Configuration
import os
import sys
import bottle
import json
import mysql.connector

mysql_info = dict()
# Return status of MySQL database
# -bottle.route registers the index route to this function
@bottle.route('/')
def index():

    #Catch any possible exceptions and print them to webpage when thrown
    try:

        #2. Check if app is in BlueMix Environment
        if 'VCAP_SERVICES' in os.environ:
            
            #3. Read Connection Parameters from VCAP_SERVICES Environment Variable

            #convert vcap-services json into a dictionary
            vcap_services = json.loads(os.environ['VCAP_SERVICES'])

            #load information about mysql database into a separate dictionary
            # and then grab the credentials
            for key, value in vcap_services.iteritems():   # iter on both keys and values
                if key.startswith('mysql'):
                    mysql_info = vcap_services[key][0]
            cred = mysql_info['credentials']
            
            #store parameters
            host = cred['host'].encode('utf8')
            dbusername = cred['user'].encode('utf8')
            dbpassword = cred['password'].encode('utf8')
            dbname = cred['name'].encode('utf8')
            port = cred['port']
        else:
            #use these by default
            host = '127.0.0.1'
            port = 3306
            dbusername = 'root'
            dbpassword = 'root'
            dbname = 'starwarsFINAL'   

        #4. Make Connection to MySQL DB
        con = mysql.connector.connect(host = host, user = dbusername, password = dbpassword, database = dbname , port = port)
        cursor = con.cursor()
        
        #send a query
        cursor.execute("SELECT VERSION()")

        #grab the result
        mysql_version = 'MySQL Version: %s \n' % (cursor.fetchone())
        sys.stderr.write(mysql_version)


        cursor.execute("SELECT * FROM characters")
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
