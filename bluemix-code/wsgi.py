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

# #renders template before page load
# @bottle.route('/new')
# def queryInput():
#     return template('templates/new')

# #for the /new page, dont worry about this 
# @bottle.route('/new', method="POST")
# def test_model():

#     model = request.forms.get('model')

#     natural_language_understanding = NaturalLanguageUnderstandingV1(
#         version='2017-02-27',
#         username="8aab4e6f-ed79-45b3-9136-0d0e76597772",
#         password='k3w7UbjdobiP')

#     response = natural_language_understanding.analyze(
#         text=model,
#         features=[features.Entities(), features.Keywords()])

#     print(json.dumps(response, indent=2))


#for insert and delete statements, this is the second text box
@bottle.route('/inserted', method='POST')
def new_item():


    new = request.POST.task.strip()
    task = request.forms.get('task').lower()
    print(task)

    conn = psycopg2.connect(
        database="ygqehxjv",
        user="ygqehxjv",
        password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
        host="echo.db.elephantsql.com",
        port="5432"
        )
    c = conn.cursor()
    table = task.split()[2]

    if "add" in task or "create" in task:
        table = "student"
        name = task[task.find("named") + 6:task.find("with") - 1]
        fname = name[:name.find(" ")].capitalize()
        lname = name[name.find(" ") + 1:].capitalize()
        major = task[task.find("major") + 6:task.find("and") - 1].capitalize()
        grad = task[task.find("year") + 5:]
        task = "Insert into student (fname, lname, grad, major) values('{}','{}',{},'{}')".format(fname, lname, grad, major)
    elif "delete" in task or "drop" in task:
        table = "student"
        fname = task.split()[3]
        print(fname)
        task = "delete from student where fname = '{}'".format(fname)    

    c.execute(task, new)
    c.execute('select * from' + ' ' + table)
    result = c.fetchall()

    conn.commit()
    c.close()

    return template('templates/insert', rows=result)

#renders the templates on the page load so that the functions can get the data from the forms
#without this then the forms are not read
@bottle.route('/')
def queryInput():
    output = template('templates/front')

    return output 

#for select statements, this is the first text box
@bottle.route('/', method='POST')
def index():
    query = request.forms.get('query').lower()
    
    conn = psycopg2.connect(
            database="ygqehxjv",
            user="ygqehxjv",
            password="q4LBGXfLDhX9nWHUKwCzxquKfhTe7Tqf",
            host="echo.db.elephantsql.com",
            port="5432"
            )
    # try:
    cursor = conn.cursor()

    if "show" in query or "get" in query:
        table = query[query.find('all')+4:len(query)-1]
        query = "Select * from {}".format(table)

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
