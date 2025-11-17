import mysql.connector
from mysql.connector import errorcode
from flask import Flask, jsonify, render_template, request
from flask_cors import CORS
from datetime import date, datetime
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
import secrets
import re
from decimal import Decimal
app = Flask(__name__)
CORS(app)

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '25082005',
    'database': 'Pharmacy'
}

# Lưu admin sessions tạm (dùng dict, trong production dùng Redis/database)
admin_sessions = {}

# === HELPER FUNCTIONS ===
def is_admin_or_manager(cursor, user_id: int) -> bool:
    cursor.execute("""
        SELECT 1
        FROM User u
        LEFT JOIN Admin a ON a.UserId = u.UserId
        LEFT JOIN Sales_Manager s ON s.UserId = u.UserId
        WHERE u.UserId = %s
          AND (a.UserId IS NOT NULL OR s.UserId IS NOT NULL)
        LIMIT 1
    """, (user_id,))
    return cursor.fetchone() is not None

def hash_password(password):
    """Hash password using werkzeug"""
    return generate_password_hash(password)

def is_valid_email(email):
    """Validate email format"""
    pattern = r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def is_valid_username(username):
    """Validate username (3-30 chars, alphanumeric + underscore/dot)"""
    pattern = r'^[a-zA-Z0-9_.]{3,30}$'
    return re.match(pattern, username) is not None

def require_admin(f):
    """Decorator kiểm tra admin token"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth_header = request.headers.get('Authorization', '')
        token = auth_header.replace('Bearer ', '') if auth_header else ''
        
        if not token or token not in admin_sessions:
            return jsonify({'error': 'Unauthorized - Admin token required'}), 401
        
        return f(*args, **kwargs)
    return decorated_function

#########   ADMIN AUTHENTICATION    #########
@app.route('/api/admin/login', methods=['POST'])
def admin_login():
    """Admin login - trả về token"""

    connection = None
    cursor = None

    try:
        data = request.get_json() or {}
        username = (data.get('username') or '').strip()
        password = data.get('password') or ''
        
        if not username or not password:
            return jsonify({'error': 'Vui lòng nhập username và password'}), 400
        
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        query = """
            SELECT U.UserId, U.Username, U.HashedPassword 
            FROM User U
            JOIN Admin A ON U.UserId = A.UserId
            WHERE U.Username = %s
        """
        cursor.execute(query, (username,))
        admin = cursor.fetchone()

        if not admin:
            return jsonify({'error': 'Invalid admin credentials'}), 401
        
        hashed_password = admin['HashedPassword']

        if not check_password_hash(hashed_password, password):
            return jsonify({'error': 'Invalid admin credentials'}), 401
        
        # Tạo token ngẫu nhiên
        token = secrets.token_urlsafe(32)
        admin_sessions[token] = {
            'user_id': admin['UserId'],
            'username': admin['Username'],
            'login_time': datetime.now()
        }
        
        return jsonify({
            'success': True,
            'message': 'Admin login successful',
            'token': token,
            'username': admin['Username']
        }), 200
    
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/admin/logout', methods=['POST'])
@require_admin
def admin_logout():
    """Admin logout"""
    try:
        auth_header = request.headers.get('Authorization', '')
        token = auth_header.replace('Bearer ', '') if auth_header else ''
        
        if token in admin_sessions:
            del admin_sessions[token]
        
        return jsonify({
            'success': True,
            'message': 'Logged out successfully'
        }), 200
    
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500

# === ADMIN APIs (cần token) ===

@app.route('/admin/dashboard', methods=['GET'])
@require_admin
def get_admin_dashboard():
    """Lấy thống kê dashboard"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        # Tổng sản phẩm
        cursor.execute('SELECT COUNT(*) as total FROM Product')
        total_products = cursor.fetchone()['total']

        # Tổng người dùng
        cursor.execute('SELECT COUNT(*) as total FROM User')
        total_users = cursor.fetchone()['total']

        # Tổng đơn hàng
        cursor.execute('SELECT COUNT(*) as total FROM `Order`')
        total_orders = cursor.fetchone()['total']

        # Tổng doanh thu
        cursor.execute('''
            SELECT COALESCE(SUM(OAD.Quantity * P.Price), 0) as total
            FROM Order_are_Detail OAD
            JOIN Product P ON OAD.ProductId = P.ProductId
        ''')
        total_revenue = cursor.fetchone()['total']

        return jsonify({
            'total_products': total_products,
            'total_users': total_users,
            'total_orders': total_orders,
            'total_revenue': float(total_revenue)
        }), 200

    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/admin/users', methods=['GET'])
@require_admin
def get_admin_users():
    """Lấy danh sách người dùng"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        cursor.execute('''
            SELECT UserId, Username, Email, Fname, Lname, Address, Dob
            FROM User
            ORDER BY UserId DESC
        ''')
        users = cursor.fetchall()

        return jsonify(users), 200

    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/admin/orders', methods=['GET'])
@require_admin
def get_admin_orders():
    """Lấy danh sách đơn hàng"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        cursor.execute('''
            SELECT O.OrderId, O.OrderDate, O.Status, U.Username, U.Email
            FROM `Order` O
            JOIN User U ON O.UserId = U.UserId
            ORDER BY O.OrderDate DESC
        ''')
        orders = cursor.fetchall()

        return jsonify(orders), 200

    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/admin/top_buyers', methods=['GET'])
@require_admin
def get_admin_top_buyers():
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        cursor.execute('''
            select u.UserId, u.Username, u.Email, u.Fname, u.Lname, v.TotalSpent
            from pharmacy.vw_topbuyers as v
            join user as u
            on v.UserId = u.UserId
            order by v.TotalSpent desc;
            ''')
        top_buyers = cursor.fetchall()

        return jsonify(top_buyers), 200
    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

# === PAGE ROUTES ===

@app.route('/')
def index_page():
    return render_template('index.html')

@app.route('/list_products.html')
def list_products_page():
    return render_template('list_products.html')

@app.route('/new_product_form.html')
def new_product_page():
    return render_template('new_product_form.html')

@app.route('/login_register.html')
def login_register_page():
    return render_template('login_register.html')

@app.route('/admin_login.html')
def admin_login_page():
    return render_template('admin_login.html')

@app.route('/admin_dashboard.html')
def admin_dashboard_page():
    return render_template('admin_dashboard.html')

@app.route('/cart.html')
def cart_page():
    return render_template('cart.html')

#########   LOGIN/REGISTER    #########

@app.route('/api/register', methods=['POST'])
def register():
    """Register user account"""
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        fname = (data.get('fname') or '').strip()
        lname = (data.get('lname') or '').strip()
        email = (data.get('email') or '').strip()
        username = (data.get('username') or '').strip()
        password = data.get('password') or ''
        confirm_password = data.get('confirm_password') or ''
        dob_str = data.get('dob') or None
        address = (data.get('address') or '').strip()

        if not all([fname, lname, email, username, password, confirm_password]):
            return jsonify({'error': 'Vui lòng điền tất cả các trường bắt buộc'}), 400

        if not is_valid_email(email):
            return jsonify({'error': 'Email không hợp lệ'}), 400

        if not is_valid_username(username):
            return jsonify({'error': 'Tên đăng nhập phải 3-30 ký tự (chữ, số, _ hoặc .)'}), 400

        if len(password) < 6:
            return jsonify({'error': 'Mật khẩu phải ít nhất 6 ký tự'}), 400

        if password != confirm_password:
            return jsonify({'error': 'Mật khẩu không trùng khớp'}), 400

        dob = None
        if dob_str:
            try:
                dob = datetime.fromisoformat(dob_str).date()
            except:
                try:
                    dob = datetime.strptime(dob_str, '%Y-%m-%d').date()
                except:
                    return jsonify({'error': 'Định dạng ngày sinh không hợp lệ (YYYY-MM-DD)'}), 400

            today = date.today()
            age = today.year - dob.year - ((today.month, today.day) < (dob.month, dob.day))
            if age < 18 or age > 94:
                return jsonify({'error': 'Tuổi không hợp lệ (phải từ 18 đến 94)'}), 400

        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        cursor.execute('SELECT UserId FROM User WHERE Username = %s', (username,))
        if cursor.fetchone():
            return jsonify({'error': 'Tên đăng nhập đã tồn tại'}), 400

        cursor.execute('SELECT UserId FROM User WHERE Email = %s', (email,))
        if cursor.fetchone():
            return jsonify({'error': 'Email đã được đăng ký'}), 400

        hashed = hash_password(password)

        insert_sql = "CALL sp_AddBuyerAccount(%s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(insert_sql, (fname, lname, email, username, hashed, dob, address))
        connection.commit()

        user_id = cursor.lastrowid
        return jsonify({
            'success': True,
            'message': 'Đăng ký thành công',
            'user_id': user_id
        }), 201

    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/login', methods=['POST'])
def login():
    """Login user account"""
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        username_or_email = (data.get('username') or '').strip()
        password = data.get('password') or ''

        if not username_or_email or not password:
            return jsonify({'error': 'Vui lòng nhập tên đăng nhập/email và mật khẩu'}), 400

        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        cursor.execute(
            'SELECT UserId, Username, Email, Fname, Lname, HashedPassword FROM User WHERE Username = %s OR Email = %s',
            (username_or_email, username_or_email)
        )
        user = cursor.fetchone()

        if not user:
            return jsonify({'error': 'Tên đăng nhập hoặc email không tồn tại'}), 401

        if not check_password_hash(user['HashedPassword'], password):
            return jsonify({'error': 'Mật khẩu không chính xác'}), 401

        return jsonify({
            'success': True,
            'message': 'Đăng nhập thành công',
            'user': {
                'user_id': user['UserId'],
                'username': user['Username'],
                'email': user['Email'],
                'fname': user['Fname'],
                'lname': user['Lname']
            }
        }), 200

    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

#########   LIST PRODUCTS    #########

@app.route('/list_products', methods=['GET'])
def list_products():
    """Lấy danh sách sản phẩm"""

    category_id_str = request.args.get('category_id') 

    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        # Sử dụng dictionary=True để trả về list of dicts dễ xử lý ở frontend
        cursor = connection.cursor(dictionary=True) 
        
        if category_id_str == 'all' or category_id_str is None:
            query = 'CALL sp_GetAllProducts()'
            cursor.execute(query)
        else:
            try:
                category_id = int(category_id_str)
            except ValueError:
                return jsonify({'error': 'Định dạng Category ID không hợp lệ.'}), 400
            
            query = 'CALL sp_GetProductsByCategory(%s)'
            cursor.execute(query, (category_id,))
            
        products = cursor.fetchall()
        
        # Bắt buộc: Tiêu thụ hết các tập hợp kết quả phụ từ Stored Procedure
        while cursor.nextset():
            pass 
            
        return jsonify(products), 200
    except mysql.connector.Error as db_err:
        # In lỗi cụ thể của MySQL ra console để kiểm tra SP
        print(f"MySQL Error in list_products: {db_err}")
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        # In lỗi Python ra console để gỡ lỗi chính xác hơn
        print(f"LỖI CHUNG TRONG list_products: {e}") 
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/update_product', methods=['POST'])
def update_product():
    """Cập nhật sản phẩm"""
    connection = None
    cursor = None
    try:
        data = request.get_json()
        print(data)
        product_id = data.get('ProductId')
        name = data.get('Name')
        price = data.get('Price')
        stock = data.get('Stock')
        description = data.get('Description')
        category_id = int(data.get('CategoryId'))
        
        if not product_id or not name or price is None or stock is None or category_id is None:
            return jsonify({'error': 'Please fill in the required fields'}), 400
        
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        query = "CALL sp_UpdateProduct(%s, %s, %s, %s, %s, %s)"

        cursor.execute(query, (product_id, name, price, stock, description, category_id))
        connection.commit()
        
        # update_sql = 'UPDATE Product SET '
        # params = []
        # updates = []
        
        # if 'name' in data:
        #     updates.append('Name = %s')
        #     params.append(data['name'])
        # if 'price' in data:
        #     updates.append('Price = %s')
        #     params.append(data['price'])
        # if 'stock' in data:
        #     updates.append('Stock = %s')
        #     params.append(data['stock'])
        # if 'description' in data:
        #     updates.append('Description = %s')
        #     params.append(data['description'])
        # if 'category_id' in data:
        #     updates.append('CategoryId = %s')
        #     params.append(data['category_id'])

        # if not updates:
        #     return jsonify({'error': 'No fields to update'}), 400
        
        # update_sql += ', '.join(updates) + ' WHERE ProductId = %s'
        # params.append(product_id)
        
        # cursor.execute(update_sql, params)
        # connection.commit()
        
        return jsonify({'success': True, 'message': 'Product updated'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/delete_product/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    """Xóa sản phẩm"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute('DELETE FROM Product WHERE ProductId = %s', (int(product_id),))
        connection.commit()
        return jsonify({'success': True, 'message': 'Product deleted'}), 200
    except mysql.connector.IntegrityError as e:
        # 2. Handle Foreign Key Constraint Error (The most common issue)
        # Error code 1451 is common for MySQL FK violation
        if e.errno == errorcode.ER_ROW_IS_REFERENCED_2:
            return jsonify({
                'error': 'Cannot delete product. It is linked to existing orders or carts.'
            }), 409 # 409 Conflict
    except mysql.connector.Error as e:
        # 3. Handle other MySQL specific errors (e.g., connection lost)
        return jsonify({'error': f"Database Error: {e}"}), 500
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/add_product', methods=['POST'])
def add_product():
    """Thêm sản phẩm mới"""
    connection = None
    cursor = None

    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        data = request.get_json()

        name = data.get('Name')
        description = data.get('Description')
        price = float(data.get('Price'))
        stock = int(data.get('Stock'))
        category_id = int(data.get('CategoryId'))

        if not name or not description or price is None or stock is None:
            return jsonify({'error': 'Missing required fields.'}), 400

        query = "CALL sp_AddProduct(%s, %s, %s, %s, %s)"
        cursor.execute(query, (name, price, stock, description, category_id))
        connection.commit()

        newid = cursor.lastrowid

        return jsonify({'message': f'Product added successfully to category ID {category_id} with ID: {newid}.'}), 201
    except Exception as e:
        print(f"Error adding product: {e}")
        return jsonify({'error': str(e)}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/categories')
def get_categories():
    connection = None
    cursor = None

    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute('SELECT CategoryId, Name FROM Category')
        categories = cursor.fetchall()
        category_list = [{'CategoryId': row[0], 'Name': row[1]} for row in categories]
        return jsonify(category_list), 200
    except Exception as e:
        print(f"Error fetching categories: {e}")
        return jsonify({'error': str(e)}), 500

#########   CART    #########

def get_or_create_cart(user_id):
    """Lấy hoặc tạo cart cho user"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        
        cursor.execute('SELECT CartId FROM Cart WHERE UserId = %s', (user_id,))
        cart = cursor.fetchone()
        
        if not cart:
            cursor.execute('INSERT INTO Cart (UserId) VALUES (%s)', (user_id,))
            connection.commit()
            cart_id = cursor.lastrowid
        else:
            cart_id = cart['CartId']
        
        return cart_id
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/cart/view/<int:user_id>', methods=['GET'])
def view_cart(user_id):
    """Xem giỏ hàng của user (Loại bỏ ORDER BY tạm thời)"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        
        query = '''
            SELECT 
                CID.CartItemId,
                CID.CartId,
                CID.ProductId,  
                P.Name,
                P.Price,
                P.Stock,
                P.Description,
                CID.Amount AS Quantity, -- SỬ DỤNG ALIAS LÀ Quantity
                (CID.Amount * P.Price) AS TotalPrice
            FROM CartItem_detail CID  
            JOIN Cart C ON CID.CartId = C.CartId
            JOIN Product P ON CID.ProductId = P.ProductId
            WHERE C.UserId = %s
            -- ĐÃ LOẠI BỎ: ORDER BY CID.AddedDate DESC
        '''
        cursor.execute(query, (user_id,))
        items = cursor.fetchall()
        total_price = sum(item['TotalPrice'] for item in items) if items else 0
        return jsonify({
            'success': True,
            'items': items,
            'total_items': len(items),
            'total_price': float(total_price)
        }), 200
    except mysql.connector.Error as db_err:
        print(f"MySQL Error in view_cart: {db_err}")
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        print(f"LỖI CHUNG TRONG view_cart: {e}") 
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/cart/add', methods=['POST'])
def add_to_cart():
    """Thêm sản phẩm vào giỏ hàng"""
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        user_id = data.get('user_id')
        product_id = data.get('product_id')
        quantity = data.get('quantity', 1)
        
        if not user_id or not product_id:
            return jsonify({'error': 'user_id và product_id bắt buộc'}), 400
        
        if quantity < 1:
            return jsonify({'error': 'Số lượng phải >= 1'}), 400
        
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        
        cursor.execute('SELECT Stock FROM Product WHERE ProductId = %s', (product_id,))
        product = cursor.fetchone()
        if not product:
            return jsonify({'error': 'Sản phẩm không tồn tại'}), 404
        
        if product['Stock'] < quantity:
            return jsonify({'error': f'Chỉ còn {product["Stock"]} sản phẩm'}), 400
        cursor.callproc('sp_AddProductToCart', (user_id, product_id, quantity))

        connection.commit()
        
        return jsonify({
            'success': True,
            'message': 'Thêm vào giỏ hàng thành công',
            'user_id': user_id
        }), 200
    
    except mysql.connector.Error as db_err:
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/cart/update', methods=['PUT'])
def update_cart_item():
    """Cập nhật số lượng sản phẩm trong giỏ hàng (SỬA LẠI CHO CẤU TRÚC 2 BẢNG)"""
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        cart_item_id = data.get('cart_item_id') 
        quantity = data.get('quantity') 
        
        if not cart_item_id or quantity is None:
            return jsonify({'error': 'cart_item_id và quantity bắt buộc'}), 400
        
        if quantity < 1:
            return jsonify({'error': 'Số lượng phải >= 1'}), 400
        
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)
        
        cursor.execute(
            'SELECT ProductId FROM CartItem_detail WHERE CartItemId = %s',
            (cart_item_id,)
        )
        cart_item = cursor.fetchone()
        if not cart_item:
            return jsonify({'error': 'CartItem không tồn tại'}), 404
        
        cursor.execute('SELECT Stock FROM Product WHERE ProductId = %s', (cart_item['ProductId'],))
        product = cursor.fetchone()
        if product['Stock'] < quantity:
            return jsonify({'error': f'Chỉ còn {product["Stock"]} sản phẩm'}), 400
        
        cursor.execute(
            'UPDATE CartItem_detail SET Amount = %s WHERE CartItemId = %s',
            (quantity, cart_item_id)
        )
        connection.commit()
        
        return jsonify({
            'success': True,
            'message': 'Cập nhật thành công'
        }), 200
    
    except mysql.connector.Error as db_err:
        print(f"MySQL Error in update_cart_item: {db_err}")
        return jsonify({'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        print(f"LỖI CHUNG TRONG update_cart_item: {e}") 
        return jsonify({'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/cart/remove/<int:cart_item_id>', methods=['DELETE'])
def remove_from_cart(cart_item_id):
    """Xoá 1 sản phẩm khỏi giỏ hàng"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        cursor.execute(
            "DELETE FROM CartItem_detail WHERE CartItemId = %s",
            (cart_item_id,)
        )
        connection.commit()

        return jsonify({
            'success': True,
            'message': 'Đã xoá sản phẩm khỏi giỏ hàng'
        }), 200

    except mysql.connector.Error as db_err:
        if connection:
            connection.rollback()
        return jsonify({
            'success': False,
            'error': f'Database error: {str(db_err)}'
        }), 500

    except Exception as e:
        if connection:
            connection.rollback()
        return jsonify({
            'success': False,
            'error': f'Error: {str(e)}'
        }), 500

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/checkout.html')
def checkout_page():
    return render_template('checkout.html')

@app.route('/api/cart/clear/<int:user_id>', methods=['DELETE'])
def clear_cart(user_id):
    """Xoá toàn bộ giỏ hàng của user"""
    connection = None
    cursor = None
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()

        # Xoá theo CartId của user
        cursor.execute("SELECT CartId FROM Cart WHERE UserId = %s", (user_id,))
        row = cursor.fetchone()
        if not row:
            return jsonify({'success': True, 'message': 'Giỏ hàng đã trống'}), 200

        cart_id = row[0]

        cursor.execute("DELETE FROM CartItem_detail WHERE CartId = %s", (cart_id,))
        cursor.execute("DELETE FROM Cart WHERE CartId = %s", (cart_id,))

        connection.commit()
        return jsonify({'success': True, 'message': 'Đã xoá toàn bộ giỏ hàng'}), 200

    except mysql.connector.Error as db_err:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


@app.route('/api/checkout', methods=['POST'])
def checkout():
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        user_id = data.get('user_id')
        payment_method = (data.get('payment_method') or '').upper().strip()

        if not user_id or payment_method not in ['COD', 'BANK', 'EWALLET']:
            return jsonify({'success': False, 'error': 'Thiếu user_id hoặc payment_method'}), 400

        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        # 1. Tạo Order từ Cart
        cursor.callproc('sp_CreateOrder', (int(user_id),))
        connection.commit()

        # 2. Lấy order mới nhất của user
        cursor.execute("""
            SELECT OrderId
            FROM `Order`
            WHERE UserId = %s
            ORDER BY OrderId DESC
            LIMIT 1
        """, (user_id,))
        order_row = cursor.fetchone()
        if not order_row:
            return jsonify({'success': False, 'error': 'Không tạo được đơn hàng'}), 500

        order_id = order_row['OrderId']

        # 3. Tính tổng tiền
        cursor.execute("""
            SELECT COALESCE(SUM(oad.TotalAmount), 0) AS total
            FROM Order_are_Detail oad
            JOIN OrderDetail od
              ON oad.OrdDetail_id = od.OrdDetail_id
             AND oad.OrderId = od.OrderId
            WHERE od.OrderId = %s
        """, (order_id,))
        total_row = cursor.fetchone()
        total_amount = float(total_row['total'] or 0)

        if total_amount <= 0:
            return jsonify({'success': False, 'error': 'Đơn hàng không có sản phẩm hoặc tổng tiền = 0'}), 400

        # 4. Thanh toán
        if payment_method == 'COD':
            cursor.callproc('sp_AddCashPayment', (order_id, total_amount))

        elif payment_method == 'BANK':
            card_number = (data.get('card_number') or '').strip()
            # chấp nhận cả bank_name lẫn card_company
            bank_name = (data.get('bank_name') or data.get('card_company') or '').strip()

            if not card_number or not bank_name:
                return jsonify({'success': False, 'error': 'Thiếu thông tin thẻ ngân hàng'}), 400

            cursor.callproc('sp_AddBankPayment', (order_id, total_amount, card_number, bank_name))

        elif payment_method == 'EWALLET':
            wallet_number = (data.get('wallet_number') or '').strip()
            # chấp nhận cả wallet_provider lẫn wallet_company
            wallet_provider = (data.get('wallet_provider') or data.get('wallet_company') or '').strip()

            if not wallet_number or not wallet_provider:
                return jsonify({'success': False, 'error': 'Thiếu thông tin ví điện tử'}), 400

            cursor.callproc('sp_AddEWalletPayment', (order_id, total_amount, wallet_number, wallet_provider))

        else:
            return jsonify({'success': False, 'error': 'Phương thức thanh toán không hợp lệ'}), 400

        # 5. Shipment
        cursor.callproc('sp_AddShipment', (order_id, 'Preparing', 1, 1))

        cursor.execute("""
            SELECT s.ShipmentId, s.ShippingDate, s.Status,
                   stp.ThirdPartyId, stp.ShipperId
            FROM Shipment s
            JOIN Order_with_Shipment ows ON s.ShipmentId = ows.ShipmentId
            LEFT JOIN Shipment_Third_Party stp ON s.ShipmentId = stp.ShipmentId
            WHERE ows.OrderId = %s
            ORDER BY s.ShipmentId DESC
            LIMIT 1
        """, (order_id,))
        shipment = cursor.fetchone()

        connection.commit()

        return jsonify({
            'success': True,
            'message': 'Thanh toán và tạo đơn hàng thành công',
            'order_id': order_id,
            'amount': total_amount,
            'payment_method': payment_method,
            'shipment': shipment
        }), 200

    except mysql.connector.Error as db_err:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Database error: {str(db_err)}'}), 500

    except Exception as e:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Error: {str(e)}'}), 500

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/admin/products/add', methods=['POST'])
def api_admin_add_product():
    connection = None
    cursor = None
    try:
        data = request.get_json() or {}
        user_id = data.get('user_id')
        name = data.get('name')
        price = data.get('price')
        stock = data.get('stock')
        desc = data.get('description')
        category_id = data.get('category_id')

        if not user_id:
            return jsonify({'success': False, 'error': 'Thiếu user_id'}), 400

        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor(dictionary=True)

        #  Check quyền
        if not is_admin_or_manager(cursor, int(user_id)):
            return jsonify({'success': False, 'error': 'Bạn không có quyền quản lý sản phẩm'}), 403

        # Gọi sp_AddProduct
        cursor.callproc('sp_AddProduct', (
            name,
            float(price),
            int(stock),
            desc,
            int(category_id)
        ))
        connection.commit()

        return jsonify({'success': True, 'message': 'Thêm sản phẩm thành công'}), 200
    

    except mysql.connector.Error as db_err:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Database error: {str(db_err)}'}), 500
    except Exception as e:
        if connection:
            connection.rollback()
        return jsonify({'success': False, 'error': f'Error: {str(e)}'}), 500
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

@app.route('/api/auth/check-admin', methods=['GET'])
def api_check_admin():
    user_id = request.args.get('user_id')

    if not user_id:
        return jsonify({'is_admin': False, 'is_sales_manager': False}), 200

    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT
                EXISTS(SELECT 1 FROM Admin WHERE UserId = %s) AS is_admin,
                EXISTS(SELECT 1 FROM Sales_Manager WHERE UserId = %s) AS is_sales_manager
        """, (user_id, user_id))
        row = cursor.fetchone() or {'is_admin': 0, 'is_sales_manager': 0}
        return jsonify({
            'is_admin': bool(row['is_admin']),
            'is_sales_manager': bool(row['is_sales_manager'])
        }), 200
    finally:
        cursor.close()
        connection.close()


if __name__ == '__main__':
    app.run(debug=True, port=5001)