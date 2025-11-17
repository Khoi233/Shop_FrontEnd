const API_BASE = 'http://127.0.0.1:5001';

// lấy user_id giống cart.js
let currentUserId = localStorage.getItem('user_id');

// copy logic updateAuthStatus + handleLogout từ cart.js nếu muốn header đồng bộ
const updateAuthStatus = () => {
    const authStatusDiv = document.getElementById('auth-status');
    const user = localStorage.getItem('user'); 
    
    if (user && authStatusDiv) {
        try {
            const userData = JSON.parse(user);
            const username = userData.username; 
            
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
            
            document.getElementById('logout-btn').addEventListener('click', () => {
                localStorage.removeItem('user');
                localStorage.removeItem('user_id');
                localStorage.removeItem('username');
                window.location.href = 'login_register.html';
            });

        } catch (e) {
            console.error("Lỗi parse JSON user data:", e);
        }
    }
};

const formatCurrency = (amount) => {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
};

// Load tóm tắt giỏ hàng
const loadCartSummary = async () => {
    if (!currentUserId) {
        alert('Bạn cần đăng nhập trước khi thanh toán.');
        window.location.href = 'login_register.html';
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/api/cart/view/${currentUserId}`);
        const data = await res.json();

        if (!data.success) {
            document.getElementById('summary-total-items').textContent = '0';
            document.getElementById('summary-total-price').textContent = '0 VNĐ';
            const msgDiv = document.getElementById('checkout-message');
            msgDiv.textContent = data.error || 'Giỏ hàng đang trống.';
            msgDiv.style.color = 'red';
            return;
        }

        // 🔥 Lưu tổng tiền để dùng khi submit
        window.totalAmount = data.total_price;

        document.getElementById('summary-total-items').textContent = data.total_items;
        document.getElementById('summary-total-price').textContent = formatCurrency(data.total_price);

        if (data.total_items === 0) {
            const msgDiv = document.getElementById('checkout-message');
            msgDiv.style.color = 'red';
            msgDiv.textContent = 'Giỏ hàng của bạn trống, hãy thêm sản phẩm trước khi thanh toán.';
        }
    } catch (err) {
        console.error(err);
        const msgDiv = document.getElementById('checkout-message');
        msgDiv.style.color = 'red';
        msgDiv.textContent = 'Lỗi kết nối API khi tải giỏ hàng.';
    }
};


function setupPaymentMethodToggle() {
    const radios = document.querySelectorAll('input[name="payment_method"]');
    const bankFields = document.getElementById('bank-fields');
    const ewalletFields = document.getElementById('ewallet-fields');

    function updateVisibility() {
        const selected = document.querySelector('input[name="payment_method"]:checked').value;
        bankFields.style.display = (selected === 'BANK') ? 'block' : 'none';
        ewalletFields.style.display = (selected === 'EWALLET') ? 'block' : 'none';
    }

    radios.forEach(r => r.addEventListener('change', updateVisibility));
    updateVisibility();
}

async function submitCheckout(event) {
    event.preventDefault();

    if (!currentUserId) {
        alert('Bạn cần đăng nhập trước khi thanh toán.');
        window.location.href = 'login_register.html';
        return;
    }

    const msgDiv = document.getElementById('checkout-message');
    msgDiv.textContent = '';
    msgDiv.style.color = '#333';

    if (typeof window.totalAmount === 'undefined') {
        msgDiv.style.color = 'red';
        msgDiv.textContent = 'Không xác định được tổng tiền. Hãy tải lại trang.';
        return;
    }

    const selectedMethod = document.querySelector('input[name="payment_method"]:checked').value;
    let result;

    try {
        if (selectedMethod === 'COD') {
            // Thanh toán khi nhận hàng
            result = await placeOrderCOD(window.totalAmount);

        } else if (selectedMethod === 'BANK') {
            const cardNumber = document.getElementById('card-number').value.trim();
            const bankName = document.getElementById('bank-name').value.trim();

            if (!cardNumber || !bankName) {
                msgDiv.style.color = 'red';
                msgDiv.textContent = 'Vui lòng nhập đầy đủ thông tin thẻ ngân hàng.';
                return;
            }

            result = await placeOrderBank(window.totalAmount, cardNumber, bankName);

        } else if (selectedMethod === 'EWALLET') {
            const walletNumber = document.getElementById('wallet-number').value.trim();
            const walletProvider = document.getElementById('wallet-provider').value.trim();

            if (!walletNumber || !walletProvider) {
                msgDiv.style.color = 'red';
                msgDiv.textContent = 'Vui lòng nhập đầy đủ thông tin ví điện tử.';
                return;
            }

            result = await placeOrderEWallet(window.totalAmount, walletNumber, walletProvider);
        }

        if (!result || !result.success) {
            msgDiv.style.color = 'red';
            msgDiv.textContent = result?.error || 'Có lỗi xảy ra khi thanh toán.';
            return;
        }

        // ✅ Nếu backend trả order_id + shipment
        msgDiv.style.color = 'green';
        msgDiv.textContent =
    `Thanh toán thành công! ` +
    `Mã đơn hàng: ${result.order_id || '(không rõ)'}, ` +
    `Shipment ID: ${(result.shipment && (result.shipment.ShipmentId || result.shipment.shipment_id)) || '(chưa có)'}, ` +
    `Tổng tiền: ${formatCurrency(result.amount || window.totalAmount)}.`;


        // Sau 3 giây quay lại trang sản phẩm
        setTimeout(() => {
            window.location.href = '/';
        }, 3000);

    } catch (err) {
        console.error(err);
        msgDiv.style.color = 'red';
        msgDiv.textContent = 'Lỗi kết nối server khi thanh toán.';
    }
}


window.addEventListener('load', () => {
    updateAuthStatus();
    setupPaymentMethodToggle();
    loadCartSummary();

    const form = document.getElementById('checkout-form');
    form.addEventListener('submit', submitCheckout);
});
// ==== GỌI API BACKEND CHECKOUT ====

async function placeOrderCOD(amount) {
    const userId = localStorage.getItem('user_id');

    const res = await fetch('http://127.0.0.1:5001/api/checkout', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            user_id: userId,
            payment_method: 'COD',
            amount: amount
        })
    });

    return await res.json();
}

async function placeOrderBank(amount, cardNumber, bankName) {
    const userId = localStorage.getItem('user_id');

    const res = await fetch('http://127.0.0.1:5001/api/checkout', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            user_id: userId,
            payment_method: 'BANK',
            amount: amount,
            card_number: cardNumber,
            card_company: bankName
        })
    });

    return await res.json();
}

async function placeOrderEWallet(amount, walletNumber, walletProvider) {
    const userId = localStorage.getItem('user_id');

    const res = await fetch('http://127.0.0.1:5001/api/checkout', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            user_id: userId,
            payment_method: 'EWALLET',
            amount: amount,
            wallet_number: walletNumber,
            wallet_company: walletProvider
        })
    });

    return await res.json();
}
