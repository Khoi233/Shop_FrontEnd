const API_BASE = 'http://127.0.0.1:5001';

// Lấy user_id từ localStorage
let currentUserId = localStorage.getItem('user_id');

// === LOGIC CẬP NHẬT HEADER (SAO CHÉP TỪ SCRIPT.JS) ===
const updateAuthStatus = () => {
    const authStatusDiv = document.getElementById('auth-status');
    const user = localStorage.getItem('user'); 
    
    if (user && authStatusDiv) {
        try {
            const userData = JSON.parse(user);
            const username = userData.username; 
            
            // Cập nhật HTML để hiển thị Tên người dùng và Thoát
            authStatusDiv.innerHTML = `
                <a href="javascript:void(0);" class="action-item" style="color: #007bff; font-weight: bold; margin-right: 10px;">
                    <i class="fas fa-user-circle"></i>
                    <span>${username}</span>
                </a>
                <a href="javascript:void(0);" id="logout-btn" class="action-item" style="color: #e63946;">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Thoát</span>
                </a>
            `;
            
            document.getElementById('logout-btn').addEventListener('click', handleLogout);

        } catch (e) {
            console.error("Lỗi parse JSON user data:", e);
        }
    } else if (authStatusDiv) {
        // Nếu chưa đăng nhập, đảm bảo nó trở lại trạng thái mặc định
        authStatusDiv.innerHTML = `
            <a href="login_register.html" id="login-link" class="action-item">
                <i class="fas fa-user"></i>
                <span>Đăng nhập</span>
            </a>
        `;
    }
};

const handleLogout = () => {
    localStorage.removeItem('user');
    localStorage.removeItem('user_id');
    localStorage.removeItem('username');
    
    // Tải lại trang (cart.js sẽ tự động chuyển hướng nếu không có user_id)
    window.location.reload(); 
};
// =========================================================

// Load cart khi page tải
window.addEventListener('load', () => {
    updateAuthStatus(); // <--- GỌI HÀM CẬP NHẬT HEADER
    
    if (!currentUserId) {
        alert('Vui lòng đăng nhập để xem giỏ hàng');
        window.location.href = './login_register.html';
        return;
    }
    loadCart();
});

// Format currency
const formatCurrency = (amount) => {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
};

// Load giỏ hàng
const loadCart = async () => {
    try {
        const response = await fetch(`${API_BASE}/api/cart/view/${currentUserId}`);
        const data = await response.json();

        if (!response.ok) {
             const error = data.error || 'Unknown error fetching cart.';
             console.error('Error:', error);
             document.getElementById('cart-items-body').innerHTML = 
                `<tr><td colspan="5" style="text-align:center; color:red;">Lỗi tải dữ liệu: ${error}</td></tr>`;
             return;
        }

        const items = data.items;
        const tbody = document.getElementById('cart-items-body');
        const emptyMessage = document.getElementById('empty-cart-message');
        const cartContent = document.querySelector('.cart-container');

        if (items.length === 0) {
            cartContent.style.display = 'none';
            emptyMessage.style.display = 'block';
            return;
        }

        cartContent.style.display = 'grid'; // Hiện lại nội dung giỏ hàng
        emptyMessage.style.display = 'none'; // Ẩn thông báo giỏ hàng trống

        tbody.innerHTML = '';
        items.forEach(item => {
            const row = tbody.insertRow();
            row.innerHTML = `
                <td>
                    <div class="product-info">
                        <div>
                            <div class="product-name">${item.Name}</div>
                            <small style="color:#999;">${item.Description.substring(0, 50)}...</small>
                        </div>
                    </div>
                </td>
                <td class="price">${formatCurrency(item.Price)}</td>
                <td>
                    <div class="quantity-control">
                        <button onclick="decreaseQuantity(${item.CartItemId})">−</button>
                        <input type="number" value="${item.Quantity}" readonly>
                        <button onclick="increaseQuantity(${item.CartItemId}, ${item.Stock})">+</button>
                    </div>
                </td>
                <td class="price">${formatCurrency(item.TotalPrice)}</td>
                <td>
                    <button class="btn-remove" onclick="removeItem(${item.CartItemId})">
                        <i class="fas fa-trash"></i> Xóa
                    </button>
                </td>
            `;
        });

        // Update summary
        document.getElementById('total-items').textContent = data.total_items;
        document.getElementById('total-price').textContent = formatCurrency(data.total_price);

    } catch (err) {
        console.error('Error loading cart:', err);
        document.getElementById('cart-items-body').innerHTML = 
             `<tr><td colspan="5" style="text-align:center; color:red;">Lỗi kết nối API</td></tr>`;
    }
};

// Tăng số lượng
const increaseQuantity = async (cartItemId, maxStock) => {
    const input = event.target.parentElement.querySelector('input');
    let quantity = parseInt(input.value) + 1;

    if (quantity > maxStock) {
        alert(`Chỉ còn ${maxStock} sản phẩm`);
        return;
    }

    await updateQuantity(cartItemId, quantity);
};

// Giảm số lượng
const decreaseQuantity = async (cartItemId) => {
    const input = event.target.parentElement.querySelector('input');
    let quantity = parseInt(input.value) - 1;

    if (quantity < 1) {
        await removeItem(cartItemId);
        return;
    }

    await updateQuantity(cartItemId, quantity);
};

// Cập nhật số lượng
const updateQuantity = async (cartItemId, quantity) => {
    try {
        const response = await fetch(`${API_BASE}/api/cart/update`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ cart_item_id: cartItemId, quantity })
        });

        const data = await response.json();
        if (data.success) {
            loadCart();
        } else {
            alert('Lỗi: ' + data.error);
        }
    } catch (err) {
        console.error('Error updating quantity:', err);
        alert('Lỗi cập nhật');
    }
};

// Xóa sản phẩm
const removeItem = async (cartItemId) => {
    if (!confirm('Bạn chắc chắn muốn xóa sản phẩm này?')) return;

    try {
        const response = await fetch(`${API_BASE}/api/cart/remove/${cartItemId}`, {
            method: 'DELETE'
        });

        const data = await response.json();
        if (data.success) {
            loadCart();
            alert('Đã xóa sản phẩm');
        } else {
            alert('Lỗi: ' + data.error);
        }
    } catch (err) {
        console.error('Error removing item:', err);
        alert('Lỗi xóa sản phẩm');
    }
};

// Áp dụng mã giảm giá (TODO)
const applyPromo = () => {
    const promoCode = document.getElementById('promo-code').value.trim();
    if (!promoCode) {
        alert('Vui lòng nhập mã giảm giá');
        return;
    }
    // TODO: Call API to apply promo
    alert('Mã giảm giá chưa được triển khai');
};

// Thanh toán
const checkout = () => {
    window.location.href = './checkout.html';
};

// Tiếp tục mua sắm
const continueShopping = () => {
    window.location.href = './list_products.html';
};