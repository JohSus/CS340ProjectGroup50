from flask import Flask, render_template, url_for, json, request, redirect
from flask_mysqldb import MySQL
import os
# import database.db_connector as db

# Configuration

app = Flask(__name__)

# database connection
app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_wubr'
app.config['MYSQL_PASSWORD'] = '9544' #last 4 of onid
app.config['MYSQL_DB'] = 'cs340_wubr'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

# db_connection = db.connect_to_database()

mysql = MySQL(app)

# Routes 

def connect(command, values=None):
    mycursor = mysql.connection.cursor()
    if values:
        mycursor.execute(command, values)
        mysql.connection.commit()
    else:
        mycursor.execute(command)

    if 'SELECT' in command:
        return mycursor.fetchall



# index
@app.route("/")
def index():
    return render_template("index.html")

# orders
@app.route("/orders", methods=["POST", "GET"])
def orders():
    # READ
    if request.method == "GET":

        query = "SELECT * FROM Orders"
        orders_data = connect(query)
        # render orders table to the template
        return render_template("orders.j2", orders = orders_data)

    # ADD NEW
    if request.method == "POST":

        # for "New" link in table
        if request.form.get('insert_order'):
            order_time = request.form['order_time']
            customer_id = request.form['customer_id']
            # new row
            query = "INSERT INTO Orders (order_time, customer_id) VALUES (%s, %s);"
            values = (order_time, customer_id)
            connect(query, values)
            
            return redirect("/orders")

        if request.form["method"] == "put":
            order_id = int(request.form["order_id"])
            order_time = request.form['order_time']
            customer_id = request.form['customer_id']

            command = "UPDATE Orders SET order_time = %s, customer_id = %s WHERE order_id = %s;"
            values = (order_time, customer_id)
            connect(command, values)

            return redirect("/orders")

        if request.form["method"] == "delete":
            order_id = int(request.form["order_id"])

            command = "DELETE FROM Orders WHERE order_id = %s;"
            values = (order_id)
            connect(command, values)
            
            return redirect("/orders")

# customers
@app.route('/customers', methods = ["POST", "GET"])
def customers():
    # READ
    if request.method == "GET":

        query = "SELECT customer_id AS 'ID', customer_name AS 'Customer Name', phone_number AS 'Phone Number' FROM Customers;"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        # render edit_customer page passing query data to the edit_customers template
        return render_template("customers.j2", data = data)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_customer"):
            customer_name = request.form["customer_name"]
            phone_number = request.form["phone_number"]

            query = "INSERT INTO Customers (customer_name, phone_number) VALUES (%s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (customer_name, phone_number))
            mysql.connection.commit()

            return redirect("/customers")



@app.route('/delete_customers/<int:id>')
def delete_customers(id):
    query = "DELETE FROM Customers WHERE customer_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/customers")

@app.route('/edit_customers/<int:id>', methods=["POST", "GET"])
def edit_customers(id):
    if request.method == "GET":
        query1 = "SELECT * FROM Customers WHERE customer_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        results = cursor.fetchall()


    if request.method == "POST":
        if request.form.get("edit_customer"):
            customer_name = request.form["customer_name"]
            phone_number = request.form["phone_number"]

            query = "INSERT INTO Customers (customer_name, phone_number) VALUES (%s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (customer_name, phone_number))
            mysql.connection.commit()

            return redirect("/customers")


    return render_template("customers.j2", Customers = results)

# dishes

# order_has_dishes intersection

# ratings

# dietary_restrictions

#customer_dietary_restrictions

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9544)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)