#1. Prerequisite Configuration
import os
import sys
import bottle
import json
import mysql.connector
import psycopg2
from bottle import get, post, request, route, run, template, static_file
# from watson_developer_cloud import NaturalLanguageUnderstandingV1
# import watson_developer_cloud.natural_language_understanding.features.v1 as \
#     features

# natural_language_understanding = NaturalLanguageUnderstandingV1(
#     version='2017-02-27',
#     username="8aab4e6f-ed79-45b3-9136-0d0e76597772",
#     password='k3w7UbjdobiP')

# response = natural_language_understanding.analyze(
#     text='Bruce Banner is the Hulk and Bruce Wayne is BATMAN! '
#          'Superman fears not Banner, but Wayne.',
#     features=[features.Entities(), features.Keywords()])

# print(json.dumps(response, indent=2))

# @bottle.route('/', method='GET')
# def new_item():
#     query = request.forms.get('query')
    
#     conn = psycopg2.connect(
#             database="ygqehxjv",
#             user="ygqehxjv",
#             password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
#             host="echo.db.elephantsql.com",
#             port="5432"
#             )
#     new = request.GET.task.strip()
#     # try:
#     cursor = conn.cursor()
#     cursor.execute(query, new)


#     #Close the database connection
#     conn.commit()
#     cursor.close()

    
#     output = template('templates/insert')

#     return output

# @bottle.route('/new')
# def insertInto():
#     output = template('templates/insert')
#     return output 


@bottle.route('/inserted', method='POST')
def new_item():


    new = request.POST.task.strip()
    task = request.forms.get('task')

    conn = psycopg2.connect(
        database="ygqehxjv",
        user="ygqehxjv",
        password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
        host="echo.db.elephantsql.com",
        port="5432"
        )
    c = conn.cursor()
    table = task.split()[2]

    c.execute(task, new)
    c.execute('select * from' + ' ' + table)
    result = c.fetchall()

    conn.commit()
    c.close()

    return template('templates/insert', rows=result)

@bottle.route('/')
def queryInput():
    output = template('templates/front')

    return output 

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
        output = template('templates/results', rows=result, title=query.split()[3])
    else:
        output = template('templates/results', rows=result, title=query.split()[1])

    return output

    # except Exception as err:
    #     # return 500 error if any exceptions are thrown and report exceptions via webpage
    #     bottle.abort(500, "%s" % (err)) 

@bottle.route('/index')
def queryInput():
    output = template('templates/index')
    return output 

    '''
        <form method="post">
            Query: <input name="query" type="text" />
            <input type="submit" />
        </form>
    '''

@bottle.route('/<filename:path>')
def server_static(filename):
  return static_file(filename, root='stylesheets/')

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
