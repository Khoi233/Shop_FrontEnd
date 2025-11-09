from flask import Flask, jsonify, render_template, request
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

db_config = {
    'host': 'localhost',
    'user': 'root',          # change if needed
    'password': '25082005',          # your MySQL password
    'database': 'pharmacy'   # must match the schema name where Product table exists
}

@app.route('/list_products')
def list_products():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        cursor.execute('SELECT ProductId, Name, Price, Stock, Description FROM Product')
        rows = cursor.fetchall()

        return jsonify(rows)
    except Exception as e:
        print("Error fetching products: {}", e)
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/update_product', methods=['POST'])
def update_product():
    data = request.get_json()
    description = data.get('Description')
    product_id = data.get('ProductId')
    name = data.get('Name')
    stock = data.get('Stock')
    price = data.get('Price')

    if not all([product_id, name, description, price, stock]):
        return jsonify({'error': 'Missing data fields.'}), 400
    
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        sql_query = """
            UPDATE Product
            SET Description = %s, Name = %s, Price = %s, Stock = %s
            WHERE ProductId = %s
        """
        cursor.execute(sql_query, (description, name, float(price), int(stock), product_id))

        connection.commit()
        return jsonify({'message': f'Product {product_id} updated successfully'}), 200
    except mysql.connector.Error as db_err:
        print(f"Database error during update: {db_err}")
        return jsonify({'error': f'Database error: {db_err}'}), 500
    except Exception as e:
        print(f"General error during update: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/delete_product/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute("DELETE FROM Product WHERE ProductId = %s", (product_id,))
        connection.commit()

        print(cursor.rowcount)

        if cursor.rowcount == 0:
            return jsonify({'error': f"No product with ID {product_id} found."}), 404
        
        return jsonify({'message': f"Product {product_id} deleted successfully."}), 200
    except Exception as e:
        print(f"Error deleting product {product_id}: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        try:
            if cursor is not None:
                cursor.close()
            if connection is not None:
                connection.close()
        except Exception as close_err:
            print(f"Error closing resources: {close_err}")

@app.route('/add_product', methods=['POST'])
def add_product():
    connection = None
    cursor = None

    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        data = request.get_json()

        name = data.get('Name')
        description = data.get('Description')
        price = data.get('Price')
        stock = data.get('Stock')

        if not name or not description or price is None or stock is None:
            return jsonify({'error': 'Missing required fields.'}), 400

        query = """
INSERT INTO Product (Price, Name, Stock, Description)
VALUES (%s,%s,%s,%s)
"""
        cursor.execute(query, (price, name, stock, description))
        connection.commit()

        newid = cursor.lastrowid

        return jsonify({'message': f'Product added successfully with ID: {newid}.'}), 201
    except Exception as e:
        print(f"Error adding product: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

if __name__ == '__main__':
    app.run(debug=False)