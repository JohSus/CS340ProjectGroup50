from flask import Flask, render_template, json, request, redirect
import os
import database.db_connector as db

# Configuration

app = Flask(__name__)

app.config['MYSQL_HOS'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_wubr'
app.config['MYSQL_PASSWORD'] = '9544' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_wubr'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

db_connection = db.connect_to_database()

# Routes 

@app.route('/')
def root():
    return redirect("/customers")

@app.route('/customers', methods = ["POST", "GET"])
def customers():
    if request.method == "GET":

        query = "SELECT customer_id AS customerID, customer_name AS customerName, phone_number AS phoneNumber FROM Customers;"

        cursor = db.execute_query(db_connection = db_connection, query = query)

        results = cursor.fetchall()

    return render_template("customers.j2", Customers = results)

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9544)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)