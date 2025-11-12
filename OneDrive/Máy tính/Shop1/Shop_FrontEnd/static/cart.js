const API_BASE = 'http://127.0.0.1:5001';

// Lấy user_id từ localStorage
let currentUserId = localStorage.getItem('user_id');

// Load cart khi page tải
window.addEventListener('load', () => {
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

        if (!data.success) {
            console.error('Error:', data.error);
            return;
        }

        const items = data.items;
        const tbody = document.getElementById('cart-items-body');
        const emptyMessage = document.getElementById('empty-cart-message');

        if (items.length === 0) {
            tbody.parentElement.parentElement.style.display = 'none';
            document.querySelector('.cart-summary').style.display = 'none';
            emptyMessage.style.display = 'block';
            return;
        }

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
        alert('Lỗi tải giỏ hàng');
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