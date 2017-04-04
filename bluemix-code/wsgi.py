#1. Prerequisite Configuration
import os
import sys
import bottle
import json
import mysql.connector
import psycopg2
from bottle import get, post, request, route, run, template

# urlparse.uses_netloc.append("postgres")
# url = urlparse.urlparse(os.environ["postgres://ygqehxjv:q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf@echo.db.elephantsql.com:5432/ygqehxjv"])
# Return status of MySQL database
# -bottle.route registers the index route to this function

@bottle.route('/', method='POST')
def index():
    query = request.forms.get('query')
    
    conn = psycopg2.connect(
            database="ygqehxjv",
            user="ygqehxjv",
            password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
            host="echo.db.elephantsql.com",
            port="5432"
            )
    # try:
    cursor = conn.cursor()
    cursor.execute(query)
    result = cursor.fetchall()

    #Close the database connection
    cursor.close()

    if query[7:8] == '*':
        output = template('view', rows=result, title=query.split()[3])
    else:
        output = template('view', rows=result, title=query.split()[1])

    return output

    # except Exception as err:
    #     # return 500 error if any exceptions are thrown and report exceptions via webpage
    #     bottle.abort(500, "%s" % (err)) 

@bottle.route('/')
def queryInput():
    return '''
        <form method="post">
            Query: <input name="query" type="text" />
            <input type="submit" />
        </form>
    '''

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
