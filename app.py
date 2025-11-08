from flask import Flask, jsonify, render_template
import mysql.connector

app = Flask(__name__)

db_config = {
    'host': 'localhost',
    'user': 'root',          # change if needed
    'password': '25082005',          # your MySQL password
    'database': 'pharmacy'   # must match the schema name where Product table exists
}

@app.route('/')
def index():
    return render_template('index.html')

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

if __name__ == '__main__':
    app.run(debug=True)