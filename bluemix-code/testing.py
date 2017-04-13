query = raw_input("Query: ")
query = query.lower()

if "show" in query or "get" in query:
    table = query[query.find('all')+4:len(query)-1]

print "Select * from {}".format(table)