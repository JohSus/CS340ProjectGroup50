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
@app.route('/orders', methods = ["POST", "GET"])
def orders():
    # READ
    if request.method == "GET":

        query = "SELECT order_id AS 'ID', time AS 'Time', customer_id AS 'Customer ID', dish_quantity AS 'Dish Quantity' FROM Orders;"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        # render edit_customer page passing query data to the edit_customers template
        return render_template("orders.j2", data = data)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_order"):
            time = request.form["time"]
            customer_id = request.form["customer_id"]
            dish_quantity = request.form["dish_quantity"]

            query = "INSERT INTO Orders (time, customer_id, dish_quantity) VALUES (%s, %s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (time, customer_id, dish_quantity))
            mysql.connection.commit()

            return redirect("/orders")

@app.route('/delete_orders/<int:id>')
def delete_orders(id):
    query = "DELETE FROM Orders WHERE order_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/orders")

@app.route('/edit_orders/<int:id>', methods = ['GET', 'POST'])
def edit_orders(id):

    if request.method == "POST":
        time = request.form["time"]
        customer_id = request.form["customer_id"]
        dish_quantity = request.form["dish_quantity"]

        query = "UPDATE Orders SET time = %s, customer_id = %s , dish_quantity = %s WHERE order_id = %s;"
        values = (time, customer_id, dish_quantity, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/orders")

    if request.method == "GET":
        query1 = "SELECT order_id AS 'ID', time, customer_id AS 'customerID', dish_quantity AS 'dishQuantity' FROM Orders WHERE order_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        return render_template("edit_orders.j2", data = data)

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

@app.route('/edit_customers/<int:id>', methods = ['GET', 'POST'])
def edit_customers(id):

    if request.method == "POST":
        customer_name = request.form["customer_name"]
        phone_number = request.form["phone_number"]

        query = "UPDATE Customers SET customer_name = %s, phone_number = %s WHERE customer_id = %s;"
        values = (customer_name, phone_number, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/customers")

    if request.method == "GET":
        query1 = "SELECT customer_id AS customerID, customer_name AS customerName, phone_number AS phoneNumber FROM Customers WHERE customer_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        return render_template("edit_customers.j2", data = data)

# dishes
@app.route('/dishes', methods = ["POST", "GET"])
def dishes():
    # READ
    if request.method == "GET":

        query = "SELECT dish_id AS 'ID', dish_name AS 'Dish Name', price AS 'Price' FROM Dishes;"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        # render edit_customer page passing query data to the edit_customers template
        return render_template("dishes.j2", data = data)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_dish"):
            dish_name = request.form["dish_name"]
            price = request.form["price"]

            query = "INSERT INTO Dishes (dish_name, price) VALUES (%s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (dish_name, price))
            mysql.connection.commit()

            return redirect("/dishes")



@app.route('/delete_dishes/<int:id>')
def delete_dishes(id):
    query = "DELETE FROM Dishes WHERE dish_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/dishes")

@app.route('/edit_dishes/<int:id>', methods = ['GET', 'POST'])
def edit_dishes(id):

    if request.method == "POST":
        dish_name = request.form["dish_name"]
        price = request.form["price"]

        query = "UPDATE Dishes SET dish_name = %s, price = %s WHERE dish_id = %s;"
        values = (dish_name, price, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/dishes")

    if request.method == "GET":
        query1 = "SELECT dish_id AS ID, dish_name AS dishName, price FROM Dishes WHERE dish_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        return render_template("edit_dishes.j2", data = data)

# orders_has_dishes intersection
@app.route('/order_dishes', methods = ["POST", "GET"])
def order_dishes():
    # READ
    if request.method == "GET":

        query = "SELECT od.orders_has_dishes_id AS 'ID', od.order_id AS 'Order ID', od.dish_id AS 'Dish ID', d.dish_name AS 'Dish Name' FROM Orders_has_Dishes od JOIN Dishes d ON od.dish_id = d.dish_id;"
        query2 = "SELECT order_id AS orderID FROM Orders;"
        query3 = "SELECT dish_id AS dishID from Dishes"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        cursor.execute(query2)
        data2 = cursor.fetchall()
        cursor.execute(query3)
        data3 = cursor.fetchall()

        # render edit_order_dishes page passing query data to the edit_order_dishes template
        return render_template("order_dishes.j2", data = data, data2 = data2, data3 = data3)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_order_dishes"):
            order_id = request.form["order_id"]
            dish_id = request.form["dish_id"]

            query = "INSERT INTO Orders_has_Dishes (order_id, dish_id) VALUES (%s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (order_id, dish_id))
            mysql.connection.commit()

            return redirect("/order_dishes")



@app.route('/delete_order_dishes/<int:id>')
def delete_order_dishes(id):
    query = "DELETE FROM Orders_has_Dishes WHERE orders_has_dishes_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/order_dishes")

@app.route('/edit_order_dishes/<int:id>', methods = ['GET', 'POST'])
def edit_order_dishes(id):

    if request.method == "POST":
        order_id = request.form["order_id"]
        dish_id = request.form["dish_id"]

        query = "UPDATE Orders_has_Dishes SET order_id = %s, dish_id = %s WHERE orders_has_dishes_id = %s;"
        values = (order_id, dish_id, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/order_dishes")

    if request.method == "GET":
        query1 = "SELECT orders_has_dishes_id AS ID, order_id AS orderID, dish_id AS dishID FROM Orders_has_Dishes WHERE orders_has_dishes_id = %s;" % (id)
        query2 = "SELECT order_id AS orderID FROM Orders;"
        query3 = "SELECT dish_id AS dishID from Dishes"
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        cursor.execute(query2)
        data2 = cursor.fetchall()
        cursor.execute(query3)
        data3 = cursor.fetchall()
        return render_template("edit_order_dishes.j2", data = data, data2 = data2, data3 = data3)

# ratings
@app.route('/ratings', methods = ["POST", "GET"])
def ratings():
    # READ
    if request.method == "GET":
        query = "SELECT r.rating_id AS 'ID', r.rating AS 'Rating', r.customer_id AS 'Customer ID', r.dish_id AS 'Dish ID', d.dish_name AS 'Dish Name' FROM Ratings r JOIN Dishes d ON r.dish_id = d.dish_id;"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        # render edit_rating page passing query data to the ratings template
        return render_template("ratings.j2", data = data)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_rating"):
            rating = request.form["rating"]
            customer_id = request.form["customer_id"]
            dish_id = request.form["dish_id"]

            query = "INSERT INTO Ratings (rating, customer_id, dish_id) VALUES (%s, %s, %s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (rating, customer_id, dish_id))
            mysql.connection.commit()

            return redirect("/ratings")



@app.route('/delete_rating/<int:id>')
def delete_rating(id):
    query = "DELETE FROM Ratings WHERE rating_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/ratings")

@app.route('/edit_rating/<int:id>', methods = ['GET', 'POST'])
def edit_rating(id):

    if request.method == "POST":
        rating = request.form["rating"]
        customer_id = request.form["customer_id"]
        dish_id = request.form["dish_id"]

        query = "UPDATE Ratings SET rating = %s, customer_id = %s, dish_id = %s WHERE rating_id = %s;"
        values = (rating, customer_id, dish_id, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/ratings")

    if request.method == "GET":
        query1 = "SELECT rating_id AS ID, rating, customer_id AS customerID, dish_id AS dishID FROM Ratings WHERE rating_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        return render_template("edit_rating.j2", data = data)

# dietary_restrictions
@app.route('/dietary_restrictions', methods = ["POST", "GET"])
def dietary_restrictions():
    # READ
    if request.method == "GET":

        query = "SELECT restriction_id AS 'ID', description AS 'Description' FROM Dietary_Restrictions;"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()

        # render edit_customer page passing query data to the edit_customers template
        return render_template("dietary_restrictions.j2", data = data)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_dietary_restriction"):
            description = request.form["description"]

            query = "INSERT INTO Dietary_Restrictions (description) VALUES (%s);"
            cursor = mysql.connection.cursor()
            cursor.execute(query, (description,))
            mysql.connection.commit()

            return redirect("/dietary_restrictions")

@app.route('/delete_dietary_restrictions/<int:id>')
def delete_dietary_restrictions(id):
    query = "DELETE FROM Dietary_Restrictions WHERE restriction_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/dietary_restrictions")

@app.route('/edit_dietary_restrictions/<int:id>', methods = ['GET', 'POST'])
def edit_dietary_restrictions(id):

    if request.method == "POST":
        description = request.form["description"]

        query = "UPDATE Dietary_Restrictions SET description = %s WHERE restriction_id = %s;"
        values = (description, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/dietary_restrictions")

    if request.method == "GET":
        query1 = "SELECT restriction_id AS 'ID', description FROM Dietary_Restrictions WHERE restriction_id = %s;" % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        return render_template("edit_dietary_restrictions.j2", data = data)

# customer_dietary_restrictions interaction
@app.route('/customers_has_dietary_restrictions', methods = ["POST", "GET"])
def customers_has_dietary_restrictions():
    # READ
    if request.method == "GET":

        query = "SELECT cdr.customers_has_dietary_restrictions_id AS 'ID', cdr.customer_id AS 'Customer ID', cdr.restriction_id AS 'Dietary Restriction ID', dr.description AS 'Description' FROM Customers_has_Dietary_Restrictions cdr JOIN Dietary_Restrictions dr ON cdr.restriction_id = dr.restriction_id;"
        query2 = "SELECT customer_id AS customerID FROM Customers;"
        query3 = "SELECT restriction_id AS restrictionID from Dietary_Restrictions"
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        cursor.execute(query2)
        data2 = cursor.fetchall()
        cursor.execute(query3)
        data3 = cursor.fetchall()
        cursor = mysql.connection.cursor()

        # render edit_customers_has_dietary_restrictions page passing query data to the edit_customers_has_dietary_restrictions template
        return render_template("customers_has_dietary_restrictions.j2", data = data, data2 = data2, data3 = data3)

    # ADD NEW
    if request.method == "POST":
        if request.form.get("add_customers_has_dietary_restrictions"):
            customer_id = request.form["customer_id"]
            restriction_id = request.form["restriction_id"]

            query = "INSERT INTO Customers_has_Dietary_Restrictions (customer_id, restriction_id) VALUES (%s, %s);"
            cursor.execute(query, (customer_id, restriction_id))
            mysql.connection.commit()

            return render_template("customers_has_dietary_restrictions.j2", data2 = data2, data3 = data3)



@app.route('/delete_customers_has_dietary_restrictions/<int:id>')
def delete_customers_has_dietary_restrictions(id):
    query = "DELETE FROM Customers_has_Dietary_Restrictions WHERE customers_has_dietary_restrictions_id = %s;"
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()

    return redirect("/customers_has_dietary_restrictions")

@app.route('/edit_customers_has_dietary_restrictions/<int:id>', methods = ['GET', 'POST'])
def edit_customers_has_dietary_restrictions(id):

    if request.method == "POST":
        customer_id = request.form["customer_id"]
        restriction_id = request.form["restriction_id"]

        query = "UPDATE Customers_has_Dietary_Restrictions SET customer_id = %s, restriction_id = %s WHERE customers_has_dietary_restrictions_id = %s;"
        values = (customer_id, restriction_id, id)
        cursor = mysql.connection.cursor()
        cursor.execute(query, values)
        mysql.connection.commit()

        return redirect("/customers_has_dietary_restrictions")

    if request.method == "GET":
        query1 = "SELECT customers_has_dietary_restrictions_id AS ID, customer_id AS customerID, restriction_id AS restrictionID FROM Customers_has_Dietary_Restrictions WHERE customers_has_dietary_restrictions_id = %s;" % (id)
        query2 = "SELECT customer_id AS customerID FROM Customers;"
        query3 = "SELECT restriction_id AS restrictionID from Dietary_Restrictions"
        cursor = mysql.connection.cursor()
        cursor.execute(query1)
        data = cursor.fetchall()
        cursor.execute(query2)
        data2 = cursor.fetchall()
        cursor.execute(query3)
        data3 = cursor.fetchall()
        return render_template("edit_customers_has_dietary_restrictions.j2", data = data, data2 = data2, data3 = data3)

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9546)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True)